import 'package:flutter/material.dart';

class BottomToTopRoute extends PageRoute {
  final Widget page;

  BottomToTopRoute({required this.page});

  @override
  Color get barrierColor => Colors.transparent;

  @override
  bool get barrierDismissible => false;

  @override
  String get barrierLabel => '';

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return page;
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1), // Mulai dari bawah
        end: Offset.zero, // Berakhir di posisi normal
      ).animate(
        CurvedAnimation(parent: animation, curve: Curves.easeInOut),
      ),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(0, 1), // Tutup ke bawah
        ).animate(
          CurvedAnimation(parent: secondaryAnimation, curve: Curves.easeInOut),
        ),
        child: child,
      ),
    );
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 250);

  @override
  bool get maintainState => true;
}
