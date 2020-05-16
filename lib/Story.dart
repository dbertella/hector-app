import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hector_app/PageSlide.dart';
import 'package:hector_app/ValumeSelector.dart';
import 'package:hector_app/pages.dart';

class Story extends StatefulWidget {
  static String routeName = '/story';

  Story({Key key}) : super(key: key);

  _StoryState createState() => _StoryState();
}

class _StoryState extends State<Story> {
  PageController _pageController;

  final _assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _assetsAudioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
        },
        child: Stack(
          children: <Widget>[
            PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                String audioPath = pages[page].skip(2).take(1).first;
                if (audioPath.isNotEmpty) {
                  _assetsAudioPlayer.open(
                    Audio(audioPath),
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
                  padding: EdgeInsets.all(16),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.home,
                    size: 32,
                    color: Colors.grey[800],
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
