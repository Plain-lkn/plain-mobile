import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide AppBar, Icons, IconButton;
import 'package:flutter_appbar/flutter_appbar.dart';
import 'package:flutter_plain_application/components/icons.dart';
import 'package:flutter_plain_application/components/scheme.dart';
import 'package:flutter_plain_application/extensions/global_key.dart';
import 'package:flutter_plain_application/types.dart';
import 'package:flutter_plain_application/widgets/icon_button.dart';

class AppBarConnectionWithHeader extends StatefulWidget {
  const AppBarConnectionWithHeader({
    super.key,
    this.appBars = const [],
    required this.title,
    this.subTitle,
    this.onBack,
    this.onMoreMenu,
    required this.child
  });

  final List<AppBar> appBars;
  final String title;
  final String? subTitle;
  final VoidCallback? onBack;
  final MoreMenuCallback? onMoreMenu;
  final Widget child;

  static AppBarBehavior get headerBehavior => MaterialAppBarBehavior(
    dragOnlyExpanding: Platform.isAndroid,
    bouncing: true
  );

  static AppBarBehavior get appBarBehavior => MaterialAppBarBehavior(floating: true, alwaysScrolling: false);

  @override
  State<AppBarConnectionWithHeader> createState() => _AppBarConnectionWithHeaderState();
}

class _AppBarConnectionWithHeaderState extends State<AppBarConnectionWithHeader> {
  final controller = AppBarController();
  final moreMenuKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => controller.synchronizeWith(0, 1));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        assert(constraints.maxHeight != double.infinity);
        return  AppBarConnection(
          controller: controller,
          appBars: [
            SizedAppBar.builder(
              minExtent: 0.0,
              maxExtent: constraints.maxHeight / 3.2,
              behavior: AppBarConnectionWithHeader.headerBehavior,
              builder: (context, position) {
                return Transform.scale(
                  alignment: Alignment.center,
                  scale: 1 + (position.lentPixels.abs() / 500),
                  child: Opacity(
                    opacity: clampDouble(1 - (position.shrinkedPercent * 1.5), 0, 1),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // 메인 타이틀
                          Text(widget.title, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),

                          // 서브 타이틀
                          if (widget.subTitle != null)
                            Text(widget.subTitle!, style: TextStyle(fontSize: 16, color: Scheme.current.foreground2)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            AppBar.builder(
              behavior: AppBarConnectionWithHeader.appBarBehavior,
              builder: (context, position) {
                final headerPosition = controller.positionOf(0);
                assert(headerPosition != null);
                return Row(
                  children: [
                    // 뒤로가기 버튼
                    if (widget.onBack != null)
                      IconButton(onTap: widget.onBack!, icon: Icons.arrowLeft),

                    // 타이틀
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Opacity(
                        opacity: clampDouble((headerPosition!.shrinkedPercent - 0.5) * 2, 0, 1),
                        child: Text(widget.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    ),

                    // 더보기 버튼
                    if (widget.onMoreMenu != null)
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            key: moreMenuKey,
                            onTap: () => widget.onMoreMenu!(moreMenuKey.renderBox!), icon: Icons.moreVertical
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
            ...widget.appBars
          ],
          child: widget.child,
        );
      },
    );
  }
}