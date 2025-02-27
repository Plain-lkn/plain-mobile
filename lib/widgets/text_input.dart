import 'package:flutter/material.dart';
import 'package:flutter_plain_application/components/layouts/dimensions.dart';
import 'package:flutter_plain_application/components/layouts/spacing.dart';
import 'package:flutter_plain_application/components/scheme.dart';

/// 텍스트 필드에서 사용자가 텍스트를 입력할 시에 호출되는 함수의 타입입니다.
typedef TextInputCallback = void Function(String value);

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
    required this.position,
    required this.onUpdate,
    this.isPassword = false,
  });

  final String hintText;
  final TextInputPosition position;
  final TextInputCallback onUpdate;
  final bool isPassword;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  late final _controller = TextEditingController();

  static BorderRadius get asTop => const BorderRadius.vertical(
    top: Radius.circular(Dimensions.radius),
    bottom: Radius.circular(Dimensions.radius / 3)
  );

  static BorderRadius get asBottom => const BorderRadius.vertical(
    top: Radius.circular(Dimensions.radius / 3),
    bottom: Radius.circular(Dimensions.radius),
  );

  @override
  void initState() {
    super.initState();

    _controller.addListener(() => widget.onUpdate.call(_controller.value.text));
  }

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
      obscureText: widget.isPassword,
      cursorColor: Scheme.current.primary,
      controller: _controller,
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