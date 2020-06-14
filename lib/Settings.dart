import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hector_app/common/IconSoundButton.dart';
import 'package:hector_app/common/SizeConfig.dart';

final String text = """© 2020, All credits reserved,
Written and illustrated by Aurelie Mercier
Read by Liam Bertella
Music by Cecilia Fumanelli
App by Daniele Bertella

You can find a copy of the paperback version
of the book on Amazon!
Visit hector.aureliemercier.com
for more info and news""";

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
                    text,
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
            child: IconSoundButton(
              iconTitle: 'Back to home',
              iconPath: 'assets/images/icons/home.svg',
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
