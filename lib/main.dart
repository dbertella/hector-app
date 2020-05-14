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
          style: GoogleFonts.walterTurncoat(
            fontSize: SizeConfig.safeBlockHorizontal * 2,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
        ),
      ),
      body: Center(
        child: FlatButton(
          onPressed: () {
            Navigator.pushNamed(context, '/story');
          },
          child: SizedBox(
            width: 200.0,
            height: 250.0,
            child: Stack(
              children: [
                Image.asset('assets/images/hector-logo.png'),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white.withOpacity(0.9),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        'Read the story',
                        style: GoogleFonts.walterTurncoat(
                          fontSize: SizeConfig.safeBlockHorizontal * 2,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
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
