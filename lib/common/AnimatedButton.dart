import 'package:flutter/material.dart';
import 'package:hector_app/common/SoundMixin.dart';

class AnimatedButton extends StatefulWidget {
  final Widget child;

  const AnimatedButton({Key key, this.child}) : super(key: key);

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin, Sound {
  double _scale;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    disposeAudio();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
    playButtonSound();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      behavior: HitTestBehavior.translucent,
      child: Transform.scale(
        scale: _scale,
        child: Container(child: widget.child),
      ),
    );
  }
}
