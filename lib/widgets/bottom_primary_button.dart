import 'package:flutter/material.dart';
import 'package:flutter_plain_application/components/layouts/dimensions.dart';
import 'package:flutter_plain_application/components/layouts/spacing.dart';
import 'package:flutter_plain_application/components/scheme.dart';
import 'package:flutter_plain_application/extensions/color.dart';
import 'package:flutter_touch_ripple/widgets/touch_ripple.dart';

class BottomPrimaryButton extends StatelessWidget {
  const BottomPrimaryButton({
    super.key,
    required this.text,
    required this.onTap
  });

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TouchRipple(
      onTap: onTap,
      rippleColor: Scheme.current.background.withAlpha(50),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: Spacing.innerPadding),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Scheme.current.background.reversed,
          borderRadius: BorderRadius.circular(Dimensions.radius)
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Scheme.current.foreground.reversed
          ),
        ),
      ),
    );
  }
}