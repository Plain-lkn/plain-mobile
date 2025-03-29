import 'dart:math';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart' hide AnimatedTransitionBuilder;
import 'package:flutter/rendering.dart';
import 'package:flutter_plain_application/components/scheme.dart';
import 'package:flutter_plain_application/widgets/animated_transition_builder.dart';

class SegmentedControl extends StatelessWidget {
  const SegmentedControl({
    super.key,
    required this.index,
    required this.items,
    required this.onChange
  });

  final int index;
  final List<String> items;
  final ValueChanged<int> onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Scheme.current.segmentedBackground,
        borderRadius: BorderRadius.circular(1e10)
      ),
      child: AnimatedTransitionBuilder<double>(
        value: index.toDouble(),
        builder: (context, value) {
          return RenderSegmentedControl(
            translation: value,
            children: items.asMap().entries.map((obj) {
              final index = obj.key;
              final value = obj.value;
              final isSelected = index == this.index;

              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  HapticFeedback.vibrate();
                  onChange.call(index);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 7.5, horizontal: 15),
                  child: Text(value, style: TextStyle(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected
                      ? Scheme.current.foreground
                      : Scheme.current.foreground2
                  )),
                ),
              );
            }).toList(),
          );
        },
      )
    );
  }
}

class RenderSegmentedControl extends MultiChildRenderObjectWidget {
  const RenderSegmentedControl({
    super.key,
    required super.children,
    required this.translation,
  });

  /// 0 ~ [double.infinity]
  final double translation;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return SegmentedControlRenderBox(translation: translation);
  }

  @override
  void updateRenderObject(BuildContext context, SegmentedControlRenderBox renderObject) {
    renderObject.translation = translation;
  }
}

class SegmentedControlRenderBox extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, SegmentedControlParentData> {

  SegmentedControlRenderBox({
    required double translation
  }) : _translation = translation;

  late double _translation;
  double get translation => _translation;
  set translation(double newValue) {
    if (_translation != newValue) {
      _translation = newValue;
      markNeedsLayout();
    }
  }

  final _children = <RenderBox>[];

  double getBackgroundShift() {
    final begin = translation.floor();
    assert(begin <= _children.length);

    final accumulated = _children
      .take(begin)
      .fold(0.0, (sum, child) => sum + child.size.width);

    return lerpDouble(
      accumulated,
      accumulated + _children[begin].size.width,
      translation - begin
    )!;
  }

  Size getBackgroundSize() {
    final begin = translation.floor();
    final end = translation.ceil();
    assert(begin <= _children.length);
    assert(end <= _children.length);

    return Size.lerp(
      _children[begin].size,
      _children[end].size,
      translation - begin
    )!;
  }

  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! SegmentedControlParentData) {
      child.parentData = SegmentedControlParentData();
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    for (final child in _children.reversed) {
      final childParentData = child.parentData as SegmentedControlParentData;
      final childPosition = position - childParentData.shiftedOffset;
      if (child.hitTestChildren(result, position: childPosition)) return true;
    }

    return false;
  }

  @override
  void performLayout() {
    _children.clear();
    double width = 0;
    double height = 0;

    for (var child = firstChild; child != null; child = childAfter(child)) {
      final childSize = ChildLayoutHelper.layoutChild(child, constraints);
      _children.add(child);

      width += childSize.width;
      height = max(height, childSize.height);
    }

    size = Size(
      min(width, constraints.maxWidth),
      min(height, constraints.maxHeight)
    );
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final x = offset.dx;
    final y = offset.dy;
    final bgSize = getBackgroundSize();
    final bgDx = getBackgroundShift();
    final rect = Rect.fromLTRB(x + bgDx, y, (x + bgDx) + bgSize.width, y + bgSize.height);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(1e10));

    context.canvas.drawRRect(rrect, Paint()..color = Scheme.current.background);

    // 그 이후 자식들 렌더링.
    double shift = 0;

    for (final child in _children) {
      final parentData = child.parentData as SegmentedControlParentData;
      parentData.shiftedOffset = Offset(shift, 0);

      context.paintChild(child, Offset(x + shift, y));
      shift += child.size.width;
    }
  }
}

class SegmentedControlParentData extends ContainerBoxParentData<RenderBox> {
  Offset shiftedOffset = Offset.zero;
}