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
  bool _visible;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this)
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          _runAnimation();
        }
      });
    _visible = true;
  }

  void _runAnimation() {
    setState(() {
      _visible = false;
    });

    _timer = Timer(const Duration(seconds: 5), () {
      setState(() {
        _visible = true;
      });

      _controller.reset();
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? 1 : 0,
      duration: const Duration(milliseconds: 300),
      child: Lottie.asset(
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
      ),
    );
  }
}
