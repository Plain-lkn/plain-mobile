import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_plain_application/components/layouts/dimensions.dart';
import 'package:flutter_plain_application/components/layouts/spacing.dart';
import 'package:flutter_plain_application/components/scheme.dart';
import 'package:flutter_plain_application/widgets/column_list.dart';
import 'package:flutter_plain_application/widgets/designed_app.dart';
import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';

class MoreMenuItem {
  const MoreMenuItem({
    required this.onTap,
    required this.title
  });

  final VoidCallback onTap;
  final String title;
}

class MoreMenuController {
  static OverlayEntry? activeEntry;

  /// 주어진 [renderBox]는 더보기 메뉴의 오버레이가 위치해야 할 위젯의 [RenderBox]를 정의합니다.
  static void open(BuildContext context, RenderBox renderBox, List<MoreMenuItem> items) {
    final key = GlobalKey<_MoreMenuState>();

    Overlay.of(context).insert(activeEntry = OverlayEntry(
      builder: (context) {
        return DesignedApp(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              Listener(behavior: HitTestBehavior.opaque, onPointerDown: (_) => key.currentState?.close()),
              RenderMoreMenu(
                target: renderBox,
                child: MoreMenu(key: key, items: items)
              ),
            ],
          ),
        );
      },
    ));
  }

  static void close() {
    activeEntry?.remove();
    activeEntry = null;
  }
}

class MoreMenu extends StatefulWidget {
  const MoreMenu({
    super.key,
    required this.items
  });

  final List<MoreMenuItem> items;

  @override
  State<MoreMenu> createState() => _MoreMenuState();
}

class _MoreMenuState extends State<MoreMenu> with SingleTickerProviderStateMixin {
  late final _fadeAnimation = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  late final _fadeCurved = CurvedAnimation(
    parent: _fadeAnimation,
    curve: Curves.easeOutBack,
    reverseCurve: Curves.easeInQuart
  );

  double get fadePercent => _fadeCurved.value;

  /// 별도의 페이드 애니메이션을 거쳐서 더보기 메뉴를 닫습니다.
  void close() {
    if (_fadeAnimation.status == AnimationStatus.reverse) return;
    _fadeAnimation.reverse();
    _fadeAnimation.addStatusListener((status) {
      // 오버레이 요소는 어차피 고유하므로 컨트롤러에서 별도로 close 함수를 호출합니다.
      if (status == AnimationStatus.dismissed) MoreMenuController.close();
    });
  }

  @override
  void initState() {
    super.initState();

    _fadeAnimation.addListener(() => setState(() {}));
    _fadeAnimation.forward();
  }

  @override
  void dispose() {
    _fadeAnimation.dispose();
    _fadeCurved.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: clampDouble(fadePercent, 0, 1),
      child: Transform.scale(
        alignment: Alignment.topCenter,
        scaleX: 0.8 + fadePercent * 0.2,
        scaleY: 0.6 + fadePercent * 0.4,
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(50),
                blurRadius: 5.0,
                spreadRadius: 0.0,
                offset: const Offset(0, 5)
              )
            ],
            borderRadius: BorderRadius.circular(Dimensions.radius),
            color: Scheme.current.moreMenu,
          ),
          child: RawColumnList(
            items: widget.items.map((item) {
              return TouchRipple(
                onTap: () {
                  item.onTap.call();
                  close();
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(Spacing.innerPadding),
                  child: Text(item.title, style: TextStyle(fontSize: 16)),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class RenderMoreMenu extends SingleChildRenderObjectWidget {
  const RenderMoreMenu({
    super.key,
    required super.child,
    required this.target,
  });

  /// 오버레이가 위치해야 할 위젯의 [RenderBox]를 정의합니다.
  final RenderBox target;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return MoreMenuRenderBox(target: target);
  }
}

class MoreMenuRenderBox extends RenderBox with RenderObjectWithChildMixin<RenderBox> {
  MoreMenuRenderBox({
    required this.target
  });

  final RenderBox target;

  @override
  RenderBox get child => super.child!;

  Offset translate(Offset offset) {
    final targetOffset = target.localToGlobal(Offset.zero);
    final size = target.size;
    final right = targetOffset.dx + child.size.width;

    Offset result = Offset(targetOffset.dx, targetOffset.dy + size.height);

    // 오버레이가 뷰포트(viewport)를 벗어나는 경우 위치를 재조정합니다.
    if (right > constraints.maxWidth) {
      result = result.translate(constraints.maxWidth - right, 0);
    }

    return result;
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return child.hitTestChildren(result, position: position);
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    return result.addWithPaintOffset(
      offset: translate(position),
      position: position,
      hitTest: (BoxHitTestResult result, Offset transformedPosition) {
        return child.hitTest(result, position: transformedPosition);
      },
    );
  }

  @override
  void performLayout() {
    final double minHeight = child.getMinIntrinsicHeight(constraints.maxWidth);
    final double minWidth = child.getMaxIntrinsicWidth(minHeight);

    child.layout(constraints.copyWith(maxWidth: minWidth, maxHeight: minHeight), parentUsesSize: true);
    size = child.size;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.paintChild(child, translate(offset));
  }
}