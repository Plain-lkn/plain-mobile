import 'package:flutter/material.dart';

/// 특정 조건에서만 상호작용이 가능할 때, 해당 위젯을 랩핑하여 사용합니다.
class Activatable extends StatefulWidget {
  const Activatable({
    super.key,
    required this.isActive,
    required this.child
  });

  final bool isActive;
  final Widget child;

  @override
  State<Activatable> createState() => _ActivatableState();
}

class _ActivatableState extends State<Activatable> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  late final _curved = CurvedAnimation(parent: _controller, curve: Curves.ease);

  @override
  void initState() {
    super.initState();

    if (widget.isActive) _controller.value = 1;
  }

  @override
  void didUpdateWidget(covariant Activatable oldWidget) {
    super.didUpdateWidget(oldWidget);

    widget.isActive
      ? _controller.forward()
      : _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.isActive,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: 0.5 + 0.5 * _curved.value,
            child: widget.child,
          );
        },
      ),
    );
  }
}