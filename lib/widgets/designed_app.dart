import 'package:flutter/material.dart';
import 'package:flutter_plain_application/components/scheme.dart';
import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';

class DesignedApp extends StatelessWidget {
  const DesignedApp({
    super.key,
    this.backgroundColor,
    required this.child
  });

  final Color? backgroundColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Scheme.current.background,
      body: DefaultTextStyle(
        style: TextStyle(color: Scheme.current.foreground),
        child: TouchRippleStyle(
          rippleColor: Scheme.current.ripple,
          child: child
        ),
      ),
    );
  }
}