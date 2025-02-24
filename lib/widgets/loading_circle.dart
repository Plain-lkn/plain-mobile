import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_plain_application/components/scheme.dart';

class LoadingCircle extends StatefulWidget {
  const LoadingCircle({
    super.key,
    this.size = 40,
    this.color
  });

  final double size;
  final Color? color;

  @override
  State<LoadingCircle> createState() => _LoadingCircleState();
}

class _LoadingCircleState extends State<LoadingCircle> with TickerProviderStateMixin {
  final double minExtent = 0.1;
  final double maxExtent = 0.8;

  late final AnimationController _startAnimation = AnimationController(vsync: this, duration: Duration(milliseconds: 800));
  late final AnimationController _sweepAnimation = AnimationController(vsync: this, duration: Duration(milliseconds: 800));
  late final AnimationController _rotateAnimation = AnimationController.unbounded(vsync: this, duration: Duration(seconds: 1));

  late final Tween<double> _startTween = Tween(begin: 0, end: 0);
  late final Tween<double> _sweepTween = Tween(begin: 0, end: 0);

  double get startValue => _startTween.transform(Curves.ease.transform(_startAnimation.value));
  double get sweepValue => _sweepTween.transform(Curves.ease.transform(_sweepAnimation.value));
  double get rotateValue => _rotateAnimation.value;

  @override
  void initState() {
    super.initState();

    _startAnimation.addListener(() => setState(() {}));
    _startAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _sweepTween.begin = sweepValue;
        _sweepTween.end = sweepValue + (maxExtent - minExtent);

        _sweepAnimation.reset();
        _sweepAnimation.forward();
      }
    });

    _sweepTween.begin = 0;
    _sweepTween.end = maxExtent;
    _sweepAnimation.forward();
    _sweepAnimation.addListener(() => setState(() {}));
    _sweepAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _startTween.begin = startValue;
        _startTween.end = startValue + (maxExtent - minExtent);

        _startAnimation.reset();
        _startAnimation.forward();
      }
    });

    _rotateAnimation.animateTo(1);
    _rotateAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _rotateAnimation.animateTo(rotateValue + 1);
      }
    });
  }

  @override
  void dispose() {
    _startAnimation.dispose();
    _sweepAnimation.dispose();
    _rotateAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: (pi * 2) * rotateValue,
      child: Align(
        child: CustomPaint(
          size: Size(widget.size, widget.size),
          painter: LoadingCirclePainter(
            color: widget.color ?? Scheme.current.primary,
            start: startValue,
            sweep: sweepValue,
          ),
        ),
      ),
    );
  }
}

class LoadingCirclePainter extends CustomPainter {
  LoadingCirclePainter({
    required this.color,
    required this.start,
    required this.sweep
  });

  final Color color;
  final double start;
  final double sweep;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = size.width / 7;

    final startValue = start * (pi * 2);
    final sweepValue = sweep * (pi * 2);

    canvas.drawArc(
      Rect.fromLTRB(0, 0, size.width, size.height),
      startValue,
      sweepValue - startValue,
      false,
      paint
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}