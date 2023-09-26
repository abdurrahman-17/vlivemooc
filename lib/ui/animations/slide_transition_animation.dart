import 'dart:async';

import 'package:flutter/material.dart';

class SlideTransitionAnimation extends StatefulWidget {
  final Widget child;
  final double beginx;
  final double beginy;
  final double endx;
  final double endy;

  final Duration duration;
  const SlideTransitionAnimation(
      {super.key,
      required this.child,
      required this.duration,
      this.beginx = 0.5,
      this.beginy = 0,
      this.endx = 0,
      this.endy = 0});

  @override
  State<SlideTransitionAnimation> createState() =>
      _SlideTransitionAnimationState();
}

class _SlideTransitionAnimationState extends State<SlideTransitionAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<Offset>(
      begin: Offset(widget.beginx, widget.beginy),
      end: Offset(widget.endx, widget.endy),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInCubic,
    ));
    Timer(const Duration(milliseconds: 500), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: widget.child,
    );
  }
}
