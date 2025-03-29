import 'dart:ui';

import 'package:flutter/material.dart';

typedef TransitionWidgetBuilder<T> = Widget Function(BuildContext context, T value);
typedef TransitionHandler<T> = T Function(T begin, T end, double t);

/// 변화된 주어진 값을 이전 값과 보간하여 애니메이션화하도록 합니다다.
class AnimatedTransitionBuilder<T> extends StatefulWidget {
  const AnimatedTransitionBuilder({
    super.key,
    required this.value,
    required this.builder,
    this.handler
  });

  final T value;
  final TransitionHandler? handler;
  final TransitionWidgetBuilder<T> builder;

  @override
  State<AnimatedTransitionBuilder> createState() => _AnimatedTransitionBuilderState<T>();
}

class _AnimatedTransitionBuilderState<T> extends State<AnimatedTransitionBuilder<T>> with SingleTickerProviderStateMixin {
  late final AnimationController _animation = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  late final CurvedAnimation _curved = CurvedAnimation(parent: _animation, curve: Curves.ease);

  TransitionHandler get handler => widget.handler ?? (a, b, t) => lerpDouble(a, b, t);

  double get animValue => _curved.value;

  late T oldValue = widget.value;
  late T newValue = widget.value;
  T get current => handler(oldValue, newValue, animValue);

  @override
  void initState() {
    super.initState();
    _animation.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _animation.dispose();
    _curved.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AnimatedTransitionBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.value != widget.value) {
      oldValue = current;
      newValue = widget.value;
      _animation.reset();
      _animation.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, current);
  }
}