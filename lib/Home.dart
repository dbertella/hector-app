import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hector_app/ButterflyAnimation.dart';
import 'package:hector_app/common/HectorStoryButton.dart';
import 'package:hector_app/common/IconSoundButton.dart';
import 'package:hector_app/common/SizeConfig.dart';

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
      body: Stack(
        children: [
          ButterflyAnimation(),
          Container(
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
                        child:
                            Image.asset('assets/images/HectorLauncherIcon.png'),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: HectorStoryButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/story');
                        },
                        buttonWidth: buttonWidth,
                        buttonHeight: SizeConfig.safeBlockHorizontal * 5,
                        child: Text(
                          'Read the story',
                          style: GoogleFonts.gloriaHallelujah(
                            fontSize: SizeConfig.safeBlockHorizontal * 2,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: IconSoundButton(
                iconTitle: 'Settings',
                iconPath: 'assets/images/icons/settings.svg',
                iconSize: SizeConfig.safeBlockHorizontal * 5,
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                }),
          ),
          // Align(
          //   alignment: Alignment.topRight,
          //   child: SettingsButton(
          //     iconSize: SizeConfig.safeBlockHorizontal * 5,
          //     onPressed: () {
          //       Navigator.pushNamed(context, '/games');
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
