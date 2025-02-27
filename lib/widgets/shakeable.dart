import 'package:flutter/material.dart';

class Shakeable extends StatefulWidget {
  const Shakeable({
    super.key,
    required this.isActive,
    required this.child
  });

  final bool isActive;
  final Widget child;

  @override
  State<Shakeable> createState() => _ShakeableState();
}

class _ShakeableState extends State<Shakeable> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500));

  late final _shakeAnimation = TweenSequence<double>([
    TweenSequenceItem(tween: Tween(begin: 0, end: -1), weight: 1),
    TweenSequenceItem(tween: Tween(begin: -1, end: 1), weight: 2),
    TweenSequenceItem(tween: Tween(begin: 1, end: -1), weight: 2),
    TweenSequenceItem(tween: Tween(begin: -1, end: 1), weight: 2),
    TweenSequenceItem(tween: Tween(begin: 1, end: 0), weight: 1),
  ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  double get animValue => _shakeAnimation.value;

  @override
  void didUpdateWidget(covariant Shakeable oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!oldWidget.isActive && widget.isActive) {
      _controller.isCompleted
        ? _controller.reverse()
        : _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(15 * animValue, 0),
          child: widget.child,
        );
      },
    );
  }
}