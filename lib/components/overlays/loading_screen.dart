import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plain_application/components/scheme.dart';
import 'package:flutter_plain_application/widgets/designed_app.dart';
import 'package:flutter_plain_application/widgets/loading_circle.dart';
import 'package:flutter_plain_application/widgets/popup_wrapper.dart';

class LoadingScreenController {
  static OverlayEntry? activeEntry;

  static void open(BuildContext context, AsyncCallback callback) {
    Overlay.of(context).insert(activeEntry = OverlayEntry(
      builder: (context) {
        return DesignedApp(
          backgroundColor: Colors.transparent,
          child: LoadingScreen(callback: callback)
        );
      },
    ));
  }

  static void close() {
    activeEntry?.remove();
    activeEntry = null;
  }
}

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({
    super.key,
    required this.callback
  });

  final AsyncCallback callback;

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  late final _curved = CurvedAnimation(parent: _controller, curve: Curves.ease);

  void close() {
    _controller.reverse();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) LoadingScreenController.close();
    });
  }

  @override
  void initState() {
    super.initState();

    _controller.addListener(() => setState(() {}));
    _controller.forward();

    // 비동기 처리가 끝날 때
    widget.callback.call().then((_) => close());
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _curved.value,
      child: PopupWrapper(
        child: LoadingCircle(),
      )
    );
  }
}