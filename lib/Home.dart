import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hector_app/SizeConfig.dart';

class HomePage extends StatelessWidget {
  static double buttonWidth;
  static double buttonHeight;

  void _initButtonSize() {
    final double safeWidth = SizeConfig.safeBlockVertical * 65;
    buttonWidth = safeWidth > 300 ? 300 : safeWidth;
    final double safeHeight = SizeConfig.safeBlockVertical * 72;
    buttonHeight = safeHeight > 320 ? 320 : safeHeight;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    if (buttonHeight == null || buttonWidth == null) {
      this._initButtonSize();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          'Hector the little dinosaur',
          style: GoogleFonts.gloriaHallelujah(
            fontSize: SizeConfig.safeBlockHorizontal * 2.2,
            fontWeight: FontWeight.bold,
            color: Color(0xff185122),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
        },
        child: Center(
          child: SizedBox(
            width: buttonWidth,
            height: buttonHeight,
            child: Stack(
              children: [
                ClipOval(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(280.0),
                      border: Border.all(color: Color(0xff185122), width: 5.0),
                    ),
                    child: Image.asset('assets/images/hector-logo.png'),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: RaisedButton(
                    color: Color(0xfe185122),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      // side: BorderSide(
                      //   color: Colors.white,
                      //   width: 5,
                      // ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/story');
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(42, 12, 42, 12),
                      child: Text(
                        'Read the story',
                        style: GoogleFonts.gloriaHallelujah(
                          fontSize: SizeConfig.safeBlockHorizontal * 2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
