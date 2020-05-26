import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ButterflyAnimation extends StatefulWidget {
  @override
  _ButterflyAnimationState createState() => _ButterflyAnimationState();
}

class _ButterflyAnimationState extends State<ButterflyAnimation>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this)
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          print('completed');
          _runAnimation();
        }
      });
  }

  void _runAnimation() {
    _timer = new Timer(const Duration(seconds: 10), () {
      _controller.reset();
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.stop();
    return Lottie.asset(
      'assets/animations/butterfly.json',
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      controller: _controller,
      onLoaded: (composition) {
        _controller
          ..duration = composition.duration * 0.5
          ..forward();
      },
    );
  }
}
