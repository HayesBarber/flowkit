import 'package:flutter/material.dart';

class SlideBottomRoute extends PageRouteBuilder {
  final Widget page;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  Duration get reverseTransitionDuration => const Duration(milliseconds: 200);

  SlideBottomRoute({required this.page})
    : super(
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder:
            (_, Animation<double> animation, __, Widget child) =>
                SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
      );
}
