import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hector_app/common/SizeConfig.dart';
import 'package:hector_app/common/SoundButton.dart';

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
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0.0,
      //   title: Text(
      //     'Hector the little dinosaur',
      //     style: GoogleFonts.gloriaHallelujah(
      //       fontSize: SizeConfig.safeBlockHorizontal * 2.2,
      //       color: Colors.black,
      //     ),
      //   ),
      // ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/homeBg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SizedBox(
            width: buttonWidth,
            height: buttonHeight,
            child: Stack(
              children: [
                ClipOval(
                  child: Container(
                    child: Image.asset('assets/images/HectorLauncherIcon.png'),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SoundButton(
                    child: RaisedButton(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          side: BorderSide(
                            color: Colors.black,
                            width: 5.0,
                          )),
                      onPressed: () {
                        Navigator.pushNamed(context, '/story');
                      },
                      child: SizedBox(
                        width: buttonWidth,
                        height: SizeConfig.safeBlockHorizontal * 5,
                        child: Center(
                          child: Text(
                            'Read the story',
                            style: GoogleFonts.gloriaHallelujah(
                              fontSize: SizeConfig.safeBlockHorizontal * 2,
                              color: Colors.black,
                            ),
                          ),
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
