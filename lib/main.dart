import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hector_app/SizeConfig.dart';
import 'package:hector_app/Story.dart';

class Page {
  final String route;
  final WidgetBuilder builder;

  const Page({this.route, this.builder});
}

final routing = [
  Page(route: Story.routeName, builder: (context) => Story()),
];

final Map<String, WidgetBuilder> routes =
    Map.fromEntries(routing.map((d) => MapEntry(d.route, d.builder)));

void main() => runApp(StoryApp());

class StoryApp extends StatelessWidget {
  StoryApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hector the little dinosaur',
      routes: routes,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

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
      body: Center(
        child: FlatButton(
          padding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(280.0),
            side: BorderSide(color: Color(0xff185122), width: 5.0),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/story');
          },
          child: ClipOval(
            child: SizedBox(
              width: 300.0,
              height: 300.0,
              child: Stack(
                children: [
                  Image.asset('assets/images/hector-logo.png'),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(60, 8, 60, 30),
                        child: Text(
                          'Read the story',
                          style: GoogleFonts.gloriaHallelujah(
                            fontSize: SizeConfig.safeBlockHorizontal * 2,
                            // fontWeight: FontWeight.bold,
                            color: Color(0xff185122),
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
      ),
    );
  }
}
