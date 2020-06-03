import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hector_app/Games.dart';
import 'package:hector_app/Home.dart';
import 'package:hector_app/Settings.dart';
import 'package:hector_app/Story.dart';

class Page {
  final String route;
  final WidgetBuilder builder;

  const Page({this.route, this.builder});
}

final routing = [
  Page(route: Story.routeName, builder: (context) => Story()),
  Page(route: Settings.routeName, builder: (context) => Settings()),
  Page(route: WriteScreen.routeName, builder: (context) => WriteScreen()),
];

final Map<String, WidgetBuilder> routes =
    Map.fromEntries(routing.map((d) => MapEntry(d.route, d.builder)));

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
      .then((_) => runApp(new StoryApp()));
}

class StoryApp extends StatelessWidget {
  StoryApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    return MaterialApp(
      title: 'Hector the little dinosaur',
      routes: routes,
      home: HomePage(),
    );
  }
}
