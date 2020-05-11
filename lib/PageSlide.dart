import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageSlide extends StatelessWidget {
  final String path;
  final String text;

  PageSlide({
    @required this.path,
    @required this.text,
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
              fit: BoxFit.cover,
            ),
          ),
        ),
        text.isEmpty
            ? SizedBox.shrink()
            : Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white.withOpacity(0.9),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.walterTurncoat(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey, // Color(0xff185122),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}