import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hector_app/common/BackToHomeButton.dart';
import 'package:hector_app/common/SizeConfig.dart';

class Settings extends StatelessWidget {
  static String routeName = '/settings';

  Settings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '© 2020, All credits reserved',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.gloriaHallelujah(
                      fontSize: SizeConfig.safeBlockHorizontal * 2,
                      color: Colors.black, // Colors.blueGrey
                    ),
                  ),
                  Text(
                    'Written and illustrated by Aurelie Mercier',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.gloriaHallelujah(
                      fontSize: SizeConfig.safeBlockHorizontal * 2,
                      color: Colors.black, // Colors.blueGrey
                    ),
                  ),
                  Text(
                    'Read by Liam Bertella',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.gloriaHallelujah(
                      fontSize: SizeConfig.safeBlockHorizontal * 2,
                      color: Colors.black, // Colors.blueGrey
                    ),
                  ),
                  Text(
                    'Music by Cecilia Fumanelli',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.gloriaHallelujah(
                      fontSize: SizeConfig.safeBlockHorizontal * 2,
                      color: Colors.black, // Colors.blueGrey
                    ),
                  ),
                  Text(
                    'App by Daniele Bertella',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.gloriaHallelujah(
                      fontSize: SizeConfig.safeBlockHorizontal * 2,
                      color: Colors.black, // Colors.blueGrey
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: BackToHomeButton(
              iconSize: SizeConfig.safeBlockHorizontal * 5,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
