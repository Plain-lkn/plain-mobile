import 'package:flutter/material.dart';
import 'package:flutter_plain_application/components/scheme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';

class IconButton extends StatelessWidget {
  const IconButton({
    super.key,
    required this.onTap,
    required this.icon
  });

  final VoidCallback onTap;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return TouchRipple(
      onTap: onTap,
      origin: TouchRippleOrigin.center,
      rippleBorderRadius: BorderRadius.circular(1e10),
      child: Container(
        width: 50,
        height: 50,
        alignment: Alignment.center,
        child: SvgPicture.asset(icon, height: 18, color: Scheme.current.foreground),
      ),
    );
  }
}