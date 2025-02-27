import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plain_application/components/layouts/dimensions.dart';
import 'package:flutter_plain_application/components/layouts/spacing.dart';
import 'package:flutter_plain_application/components/scheme.dart';
import 'package:flutter_plain_application/utils/haptic_feedback.dart';
import 'package:flutter_plain_application/widgets/shakeable.dart';

/// 텍스트 필드에서 사용자가 텍스트를 입력할 시에 호출되는 함수의 타입입니다.
typedef TextInputCallback = void Function(String value);

enum TextInputPosition {
  all,
  top,
  center,
  bottom,
}

enum TextInputStatus {
  none,
  warning
}

/// 텍스트 입력 컨트롤러의 상태가 변경되면 호출되는 함수의 타입입니다.
typedef TextInputStatusListener = void Function(TextInputStatus status);

class TextInputController {
  final _statusListeners = ObserverList<TextInputStatusListener>();

  TextInputStatus _status = TextInputStatus.none;
  TextInputStatus get status => _status;
  set status(TextInputStatus newValue) {
    if (_status != newValue) {
      notifyStatusListeners(_status = newValue);
    }
  }

  String? warningMessage;

  void warning(String message) {
    warningMessage = message;
    status = TextInputStatus.warning;
  }

  void addStatusListener(TextInputStatusListener listener) {
    assert(!_statusListeners.contains(listener));
    _statusListeners.add(listener);
  }

  void removeStatusListener(TextInputStatusListener listener) {
    assert(_statusListeners.contains(listener));
    _statusListeners.remove(listener);
  }

  void notifyStatusListeners(TextInputStatus status) {
    for (final listener in _statusListeners) {
      listener.call(status);
    }
  }
}

class TextInput extends StatefulWidget {
  const TextInput({
    super.key,
    required this.hintText,
    required this.position,
    required this.onUpdate,
    this.isPassword = false,
    this.controller
  });

  final String hintText;
  final TextInputPosition position;
  final TextInputCallback onUpdate;
  final bool isPassword;
  final TextInputController? controller;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  late final _textController = widget.controller ?? TextInputController();
  late final _editController = TextEditingController();

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

    String oldValue = "";
    _editController.addListener(() {
      String newValue = _editController.value.text;

      if (oldValue != newValue) {
        widget.onUpdate.call(_editController.value.text);

        if (_textController.status == TextInputStatus.warning) {
          _textController.status = TextInputStatus.none;
        }

        oldValue = newValue;
      }
    });

    _textController.addStatusListener((status) => setState(() {
      if (status == TextInputStatus.warning) {
        HapticFeedbackUtil.warning();
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius;
    TextInputStatus currentStatus = _textController.status;

    switch (widget.position) {
      case TextInputPosition.all: borderRadius = BorderRadius.circular(Dimensions.radius); break;
      case TextInputPosition.top: borderRadius = asTop; break;
      case TextInputPosition.center: borderRadius = BorderRadius.zero; break;
      case TextInputPosition.bottom: borderRadius = asBottom; break;
    }

    return Column(
      children: [
        Shakeable(
          isActive: currentStatus == TextInputStatus.warning,
          child: TextField(
            style: TextStyle(color: Scheme.current.foreground),
            obscureText: widget.isPassword,
            cursorColor: Scheme.current.primary,
            controller: _editController,
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
          ),
        ),
        AnimatedSize(
          duration: Duration(milliseconds: 300),
          curve: Curves.ease,
          child: currentStatus == TextInputStatus.none
            ? SizedBox(width: double.infinity, height: 0)
            : _WarningMessage(text: _textController.warningMessage!),
        )
      ],
    );
  }
}

class _WarningMessage extends StatelessWidget {
  const _WarningMessage({
    required this.text
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Spacing.innerPadding),
      child: Text(text, style: TextStyle(color: Scheme.current.foreground2)),
    );
  }
}