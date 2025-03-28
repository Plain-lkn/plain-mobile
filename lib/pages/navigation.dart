import 'dart:ui';

import 'package:flutter/material.dart' hide Icons;
import 'package:flutter/services.dart';
import 'package:flutter_plain_application/components/icons.dart';
import 'package:flutter_plain_application/components/layouts/dimensions.dart';
import 'package:flutter_plain_application/components/layouts/spacing.dart';
import 'package:flutter_plain_application/components/scheme.dart';
import 'package:flutter_plain_application/pages/home.dart';
import 'package:flutter_plain_application/widgets/animated_fractional_translation.dart';
import 'package:flutter_plain_application/widgets/animated_transition.dart';
import 'package:flutter_svg/svg.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final _pageController = PageController();

  /// 현재 네비게이션 페이지의 인덱스를 정의합니다.
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            HomePage(),
            Center(child: Text("페이지 2")),
            Center(child: Text("페이지 3")),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: BottomNavigation(
            index: _index,
            onChange: (newIndex) {
              setState(() => _pageController.jumpToPage(_index = newIndex));
            },
          ),
        ),
      ],
    );
  }
}

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    super.key,
    required this.index,
    required this.onChange
  });

  final int index;
  final Function(int index) onChange;

  static double get height => Spacing.outerPadding + intrinsicHeight;
  static double get intrinsicHeight => 70;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Spacing.outerPadding).copyWith(top: 0),
      child: ClipRRect(
        borderRadius: Dimensions.borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            height: intrinsicHeight,
            decoration: BoxDecoration(
              color: Scheme.current.bottomNavigation,
              border: Border.all(color: Scheme.current.outline),
              borderRadius: Dimensions.borderRadius,
            ),
            child: Stack(
              children: [
                AnimatedFractionalTranslation(
                  translation: Offset(index.toDouble(), 0),
                  child: FractionallySizedBox(
                    widthFactor: 1 / 3,
                    child: Container(
                      margin: EdgeInsets.all(Spacing.innerPadding) / 2,
                      decoration: BoxDecoration(
                        borderRadius: Dimensions.borderRadius,
                        color: Scheme.current.background,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            offset: Offset(0, 5),
                            color: Colors.black.withAlpha(25),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: BottomNavigationItem(
                      isSelected: index == 0,
                      normalIcon: Icons.home,
                      filledIcon: Icons.homeFilled,
                      onTap: () => onChange.call(0),
                    )),

                    Expanded(child: BottomNavigationItem(
                      isSelected: index == 1,
                      normalIcon: Icons.compass,
                      filledIcon: Icons.compassFilled,
                      onTap: () => onChange.call(1),
                    )),

                    Expanded(child: BottomNavigationItem(
                      isSelected: index == 2,
                      normalIcon: Icons.user,
                      filledIcon: Icons.userFilled,
                      onTap: () => onChange.call(2),
                    ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNavigationItem extends StatelessWidget {
  const BottomNavigationItem({
    super.key,
    required this.isSelected,
    required this.normalIcon,
    required this.filledIcon,
    required this.onTap
  });

  final bool isSelected;
  final String normalIcon;
  final String filledIcon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        HapticFeedback.vibrate();
        onTap.call();
      },
      child: Padding(
        padding: EdgeInsets.all(Spacing.innerPadding) / 2,
        child: Center(
          child: AnimatedTransition(
            isActive: isSelected,
            start: SvgPicture.asset(normalIcon, height: 18, color: Scheme.current.foreground),
            end: SvgPicture.asset(filledIcon, height: 18, color: Scheme.current.foreground),
          ),
        ),
      ),
    );
  }
}