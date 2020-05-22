import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hector_app/common/SoundMixin.dart';

class HectorStoryButton extends StatelessWidget with Sound {
  final double buttonWidth;
  final double buttonHeight;
  final double fontSize;
  final VoidCallback onPressed;

  const HectorStoryButton({
    @required this.buttonWidth,
    @required this.buttonHeight,
    @required this.fontSize,
    @required this.onPressed,
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
        child: Center(
          child: Text(
            'Read the story',
            style: GoogleFonts.gloriaHallelujah(
              fontSize: fontSize,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
