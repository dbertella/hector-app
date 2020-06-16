import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hector_app/ButterflyAnimation.dart';
import 'package:hector_app/common/IconSoundButton.dart';
import 'package:hector_app/common/SizeConfig.dart';

final String text = """© 2020, All credits reserved
✍️ Written and illustrated by Aurelie Mercier
🤩 Read by Liam Bertella
🎵 Music by Cecilia Fumanelli
🛠 App by Daniele Bertella

📖 Order your printed copy of Hector on Amazon!
🦕 Visit hector.aureliemercier.com for more info and news.""";

class Settings extends StatelessWidget {
  static String routeName = '/settings';

  Settings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
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
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xccEEEEEE),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                    child: Text(
                      text,
                      style: GoogleFonts.gloriaHallelujah(
                        fontSize: SizeConfig.safeBlockHorizontal * 2,
                        color: Colors.black, // Colors.blueGrey
                      ),
                    ),
                  ),
                )
              ],
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

// Padding(
//   padding: const EdgeInsets.all(12.0),
//   child: HectorStoryButton(
//     onPressed: () {
//       openBrowserTab(
//           "https://tinyurl.com/hector-the-little-dinosaur");
//     },
//     buttonWidth: 250,
//     buttonHeight: SizeConfig.safeBlockHorizontal * 5,
//     child: Text(
//       'Available on Amazon',
//       style: GoogleFonts.gloriaHallelujah(
//         fontSize: SizeConfig.safeBlockHorizontal * 2,
//         color: Colors.black,
//       ),
//     ),
//   ),
// ),
// Padding(
//   padding: const EdgeInsets.all(12.0),
//   child:
//   // _isAdult
//   //     ? Text('Visit Hector\'s Website')
//   //     :
//       HectorStoryButton(
//           onPressed: () {
//             openBrowserTab(
//                 'https://hector.aureliemercier.com/');
//           },
//           buttonWidth: 250,
//           buttonHeight: SizeConfig.safeBlockHorizontal * 5,
//           child: Text(
//             'Visit Hector\'s Website',
//             style: GoogleFonts.gloriaHallelujah(
//               fontSize: SizeConfig.safeBlockHorizontal * 2,
//               color: Colors.black,
//             ),
//           ),
//         ),
// ),
