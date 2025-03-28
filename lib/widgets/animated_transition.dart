import 'package:flutter/material.dart';

class AnimatedTransition extends StatelessWidget {
  const AnimatedTransition({
    super.key,
    required this.isActive,
    required this.start,
    required this.end
  });

  final bool isActive;
  final Widget start;
  final Widget end;

  static Duration get duration => Duration(milliseconds: 300);
  static Curve get curve => Curves.ease;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedOpacity(
          opacity: isActive ? 0 : 1,
          duration: duration,
          curve: curve,
          child: start,
        ),
        AnimatedOpacity(
          opacity: isActive ? 1 : 0,
          duration: duration,
          curve: curve,
          child: end,
        ),
      ],
    );
  }
}