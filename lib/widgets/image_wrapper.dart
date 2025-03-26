import 'package:flutter/material.dart';
import 'package:flutter_plain_application/components/scheme.dart';

class ImageWrapper extends StatelessWidget {
  const ImageWrapper({
    super.key,
    this.radius = 0,
    required this.child
  });

  final double radius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final Widget widget = Container(
      color: Scheme.current.rearground,
      child: child,
    );

    if (radius == 0) {
      return widget;
    }
    
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: widget,
    );
  }
}