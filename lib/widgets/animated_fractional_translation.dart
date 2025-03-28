import 'package:flutter/material.dart';

class AnimatedFractionalTranslation extends StatefulWidget {
  const AnimatedFractionalTranslation({
    super.key,
    required this.translation,
    required this.child
  });

  final Offset translation;
  final Widget child;

  @override
  State<AnimatedFractionalTranslation> createState() => _AnimatedFractionalTranslationState();
}

class _AnimatedFractionalTranslationState extends State<AnimatedFractionalTranslation>
    with SingleTickerProviderStateMixin {

  late final _animation = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  late final _curved = CurvedAnimation(parent: _animation, curve: Curves.ease);

  late Tween<Offset> tween = Tween(
    begin: widget.translation,
    end: widget.translation
  );

  double get animValue => _curved.value;
  Offset get animTween => tween.transform(animValue);

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
  void didUpdateWidget(covariant AnimatedFractionalTranslation oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.translation != widget.translation) {
      tween.begin = animTween;
      tween.end = widget.translation;
      _animation.reset();
      _animation.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: tween.transform(animValue),
      child: widget.child,
    );
  }
}