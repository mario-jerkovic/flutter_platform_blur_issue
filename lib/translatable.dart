import 'dart:async';

import 'package:flutter/material.dart';

class Translatable extends StatefulWidget {
  final Widget foreground;

  final Widget background;

  const Translatable({
    Key? key,
    required this.foreground,
    required this.background,
  }) : super(key: key);

  @override
  State<Translatable> createState() => _Translatable();
}

class _Translatable extends State<Translatable> with SingleTickerProviderStateMixin {
  Widget? _foregroundSheet;

  Widget? _backgroundSheet;

  late final AnimationController _animationController;

  late final Animation<Offset> _foregroundSlideAnimation;

  late final Animation<double> _foregroundFadeAnimation;

  late final Animation<Offset> _backgroundSlideAnimation;

  late final Animation<double> _backgroundFadeAnimation;

  late final Animation<double> _backgroundScaleAnimation;

  @override
  void initState() {
    super.initState();

    _foregroundSheet = widget.foreground;

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    final curvedAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeInOutSine);

    _foregroundSlideAnimation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(curvedAnimation);
    _foregroundFadeAnimation = Tween<double>(begin: 1, end: 1).animate(curvedAnimation);

    _backgroundSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: Offset.zero,
    ).animate(curvedAnimation);
    _backgroundFadeAnimation = Tween<double>(begin: 1, end: 0).animate(curvedAnimation);
    _backgroundScaleAnimation = Tween<double>(begin: 1, end: 0.9).animate(curvedAnimation);

    _animationController.forward(from: 1);

    Future.delayed(const Duration(seconds: 3)).then((value) {
      _start();
    });
  }

  void _start() async {
    setState(() {
      _backgroundSheet = widget.foreground;
      _foregroundSheet = widget.background;
    });

    await _animationController.forward(from: 0);

    setState(() {
      _backgroundSheet = null;
    });

    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      _backgroundSheet = widget.foreground;
      _foregroundSheet = widget.background;
    });

    await _animationController.reverse(from: 1);

    await Future.delayed(const Duration(seconds: 3));

    _start();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController.view,
      builder: ((context, child) {
        return Stack(
          children: [
            if (_backgroundSheet != null)
              SlideTransition(
                position: _backgroundSlideAnimation,
                child: FadeTransition(
                  opacity: _backgroundFadeAnimation,
                  child: Transform.scale(
                    scale: _backgroundScaleAnimation.value,
                    child: _backgroundSheet,
                  ),
                ),
              ),
            if (_foregroundSheet != null)
              SlideTransition(
                position: _foregroundSlideAnimation,
                child: FadeTransition(
                  opacity: _foregroundFadeAnimation,
                  child: Transform.scale(
                    scale: 1,
                    child: _foregroundSheet,
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}
