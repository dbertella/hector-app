import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hector_app/PageSlide.dart';
import 'package:hector_app/ValumeSelector.dart';
import 'package:hector_app/pages.dart';

void main() => runApp(MyPageView());

class MyPageView extends StatefulWidget {
  MyPageView({Key key}) : super(key: key);

  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  PageController _pageController;
  final List<StreamSubscription> _subscriptions = [];

  final _assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _subscriptions.add(_assetsAudioPlayer.isPlaying.listen((data) {
      print("playing : $data");
    }));
    _subscriptions.add(_assetsAudioPlayer.current.listen((data) {
      print("current : $data");
    }));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          // This is the theme of your application.
          primarySwatch: Colors.green,
          backgroundColor: Colors.white),
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                String audioPath = pages[page].skip(2).take(1).first;
                if (audioPath.isNotEmpty) {
                  _assetsAudioPlayer.open(
                    Audio(audioPath),
                    respectSilentMode: true,
                  );
                  _assetsAudioPlayer.play();
                } else {
                  _assetsAudioPlayer.stop();
                }
              },
              children: pages.map(
                (content) {
                  return PageSlide(
                      path: content.take(1).first,
                      text: content.skip(1).take(1).first);
                },
              ).toList(),
            ),
            Align(
              alignment: Alignment.topRight,
              child: StreamBuilder(
                stream: _assetsAudioPlayer.volume,
                initialData: AssetsAudioPlayer.defaultVolume,
                builder: (context, snapshot) {
                  final double volume = snapshot.data;
                  return VolumeSelector(
                    volume: volume,
                    onChange: (v) {
                      _assetsAudioPlayer.setVolume(v);
                    },
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  padding: EdgeInsets.all(24),
                  onPressed: () {
                    if (_pageController.hasClients) {
                      _pageController.animateToPage(
                        0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Icon(
                    Icons.home,
                    size: 32,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
