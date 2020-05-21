import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hector_app/common/AnimatedButton.dart';
import 'package:hector_app/common/SoundMixin.dart';

class BackToHomeButton extends StatefulWidget {
  final double iconSize;
  final VoidCallback onPressed;

  const BackToHomeButton({
    @required this.iconSize,
    @required this.onPressed,
  });

  @override
  _BackToHomeButtonWidgetState createState() => _BackToHomeButtonWidgetState();
}

class _BackToHomeButtonWidgetState extends State<BackToHomeButton> with Sound {
  @override
  void dispose() {
    super.dispose();
    disposeAudio();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: AnimatedButton(
        child: IconButton(
          iconSize: widget.iconSize,
          onPressed: () {
            playButtonSound();
            widget.onPressed();
          },
          icon: SvgPicture.asset(
            'assets/images/icons/home.svg',
            semanticsLabel: 'Back to home',
          ),
          tooltip: 'Back to home',
        ),
      ),
    );
  }
}
