import 'package:flutter/material.dart';
import 'package:hector_app/common/SoundMixin.dart';

class HectorStoryButton extends StatelessWidget with Sound {
  final double buttonWidth;
  final double buttonHeight;
  final Widget child;
  final VoidCallback onPressed;

  const HectorStoryButton({
    @required this.buttonWidth,
    @required this.buttonHeight,
    @required this.onPressed,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
          side: BorderSide(
            color: Colors.black,
            width: 5.0,
          )),
      onPressed: () {
        onPressed();
        playButtonSound();
      },
      child: SizedBox(
        width: buttonWidth,
        height: buttonHeight,
        child: Center(child: child),
      ),
    );
  }
}
