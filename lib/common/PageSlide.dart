import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageSlide extends StatelessWidget {
  final String path;
  final String text;
  final double fontSize;
  final bool alignToBottom;

  PageSlide({
    @required this.path,
    @required this.text,
    @required this.fontSize,
    @required this.alignToBottom,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(path),
              fit: BoxFit.contain,
            ),
          ),
        ),
        text.isEmpty
            ? SizedBox.shrink()
            : Align(
                alignment: alignToBottom
                    ? Alignment.bottomCenter
                    : Alignment.topCenter,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white.withOpacity(0.9),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.gloriaHallelujah(
                        fontSize: fontSize,
                        color: Colors.black, // Colors.blueGrey
                      ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
