import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EnvironmentListener extends StatefulWidget {
  const EnvironmentListener({
    super.key,
    required this.onChangeBrightness,
    required this.onChangeSetting,
    required this.child
  });

  final VoidCallback onChangeBrightness;
  final VoidCallback onChangeSetting;
  final Widget child;

  @override
  State<EnvironmentListener> createState() => _EnvironmentListenerState();
}

class _EnvironmentListenerState extends State<EnvironmentListener> {
  @override
  void initState() {
    super.initState();

    PlatformDispatcher.instance.onPlatformBrightnessChanged = widget.onChangeBrightness;
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}