import 'package:flutter/material.dart';
import 'package:flutter_plain_application/widgets/designed_app.dart';

class AppPageRoute extends PageRoute {
  AppPageRoute(this.builder);

  final WidgetBuilder builder;

  @override
  bool get allowSnapshotting => false;

  @override
  Color? get barrierColor => Colors.transparent;

  @override
  Duration get transitionDuration => Duration(milliseconds: 400);

  @override
  Duration get reverseTransitionDuration => transitionDuration;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true; // 이전 페이지의 상태 유지

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child
  ) {
    final isExiting = animation.status == AnimationStatus.reverse;
    final value = isExiting
      ? Curves.easeInQuart.transformInternal(animation.value)
      : Curves.easeOutQuart.transformInternal(animation.value);

    if (animation.status.isCompleted
     || animation.status.isDismissed) {
      return child;
    }

    return Transform.scale(
      scale: 0.8 + value * 0.2,
      child: Opacity(
        opacity: value,
        child: child,
      ),
    );
  }

  @override
  DelegatedTransitionBuilder? get delegatedTransition => (
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    bool allowSnapshotting, // false로 가정
    Widget? child,
  ) {
    final isEntering = secondaryAnimation.status == AnimationStatus.reverse;
    final value = isEntering
      ? Curves.easeInQuart.transformInternal(secondaryAnimation.value)
      : Curves.easeOutQuart.transformInternal(secondaryAnimation.value);

    if (secondaryAnimation.status.isCompleted
     || secondaryAnimation.status.isDismissed) {
      return child;
    }

    return Transform.scale(
      scale: 1.2 - 0.2 * (1 - value),
      child: Opacity(
        opacity: 1 - value,
        child: child,
      ),
    );
  };

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation
  ) {
    return DesignedApp(child: builder(context));
  }
}