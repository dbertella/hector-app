import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hector_app/Home.dart';
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

void main() {
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
