import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_plain_application/components/scheme.dart';

class PopupWrapper extends StatelessWidget {
  const PopupWrapper({
    super.key,
    required this.child
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: Container(
        alignment: Alignment.center,
        color: Scheme.current.translucent,
        child: SafeArea(child: child),
      ),
    );
  }
}