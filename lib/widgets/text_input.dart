import 'package:flutter/material.dart';
import 'package:flutter_plain_application/components/layouts/dimensions.dart';
import 'package:flutter_plain_application/components/layouts/spacing.dart';
import 'package:flutter_plain_application/components/scheme.dart';

enum TextInputPosition {
  all,
  top,
  center,
  bottom,
}

class TextInput extends StatefulWidget {
  const TextInput({
    super.key,
    required this.hintText,
    required this.position
  });

  final String hintText;
  final TextInputPosition position;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  static BorderRadius get asTop => const BorderRadius.vertical(
    top: Radius.circular(Dimensions.radius),
    bottom: Radius.circular(Dimensions.radius / 3)
  );

  static BorderRadius get asBottom => const BorderRadius.vertical(
    top: Radius.circular(Dimensions.radius / 3),
    bottom: Radius.circular(Dimensions.radius),
  );

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius;

    switch (widget.position) {
      case TextInputPosition.all: borderRadius = BorderRadius.circular(Dimensions.radius); break;
      case TextInputPosition.top: borderRadius = asTop; break;
      case TextInputPosition.center: borderRadius = BorderRadius.zero; break;
      case TextInputPosition.bottom: borderRadius = asBottom; break;
    }

    return TextField(
      style: TextStyle(color: Scheme.current.foreground),
      cursorColor: Scheme.current.primary,
      decoration: InputDecoration(
        filled: true,
        fillColor: Scheme.current.rearground,
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Scheme.current.foreground2),
        contentPadding: EdgeInsets.all(Spacing.innerPadding),
        focusColor: Colors.red,
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: Scheme.current.outline, width: 1)
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(color: Scheme.current.foreground, width: 1)
        )
      ),
    );
  }
}