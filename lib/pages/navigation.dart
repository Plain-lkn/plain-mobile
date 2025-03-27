import 'dart:ui';

import 'package:flutter/material.dart' hide Icons;
import 'package:flutter_plain_application/components/icons.dart';
import 'package:flutter_plain_application/components/layouts/dimensions.dart';
import 'package:flutter_plain_application/components/layouts/spacing.dart';
import 'package:flutter_plain_application/components/scheme.dart';
import 'package:flutter_plain_application/pages/home.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        HomePage(),
        Align(
          alignment: Alignment.bottomCenter,
          child: BottomNavigation(),
        ),
      ],
    );
  }
}

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: BottomNavigationItem(isSelected: true, normalIcon: Icons.home, filledIcon: Icons.homeFilled)),
                Expanded(child: BottomNavigationItem(isSelected: false, normalIcon: Icons.compass, filledIcon: Icons.compassFilled)),
                Expanded(child: BottomNavigationItem(isSelected: false, normalIcon: Icons.user, filledIcon: Icons.userFilled))
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
    required this.filledIcon
  });

  final bool isSelected;
  final String normalIcon;
  final String filledIcon;

  @override
  Widget build(BuildContext context) {
    final renderIcon = isSelected
      ? filledIcon
      : normalIcon;

    return Padding(
      padding: EdgeInsets.all(Spacing.innerPadding) / 2,
      child: TouchRipple(
        onTap: () {},
        rippleBorderRadius: Dimensions.borderRadius,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: Dimensions.borderRadius,
            color: isSelected ? Scheme.current.background : Colors.transparent,
            boxShadow: [
              if (isSelected)
                BoxShadow(
                  blurRadius: 10,
                  offset: Offset(0, 5),
                  color: Colors.black.withAlpha(25),
                ),
            ],
          ),
          child: SvgPicture.asset(renderIcon, height: 18, color: Scheme.current.foreground),
        ),
      ),
    );
  }
}