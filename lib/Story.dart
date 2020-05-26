import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hector_app/common/BackToHomeButton.dart';
import 'package:hector_app/common/PageSlide.dart';
import 'package:hector_app/common/SizeConfig.dart';
import 'package:hector_app/common/ValumeSelector.dart';
import 'package:hector_app/common/pages.dart';

class Story extends StatefulWidget {
  static String routeName = '/story';

  Story({Key key}) : super(key: key);

  _StoryState createState() => _StoryState();
}

class _StoryState extends State<Story> {
  PageController _pageController;
  final _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
  final _assetsAudioPlayerBg = AssetsAudioPlayer.newPlayer();

  _StoryState() {
    _assetsAudioPlayer.open(
      Audio('assets/audios/cover.mp3'),
      autoStart: true,
    );

    _assetsAudioPlayerBg.open(
      Audio('assets/audios/bgMusic.mp3'),
      volume: 0.05,
      autoStart: true,
    );
    _assetsAudioPlayerBg.loop = true;
  }

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _assetsAudioPlayer.dispose();
    _assetsAudioPlayerBg.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              String audioPath = pages[page].skip(2).take(1).first;
              if (audioPath.isNotEmpty) {
                _assetsAudioPlayer.open(Audio(audioPath), autoStart: true);
              } else {
                _assetsAudioPlayer.stop();
              }
            },
            children: pages.map(
              (content) {
                return PageSlide(
                  path: content.take(1).first,
                  text: content.skip(1).take(1).first,
                  fontSize: SizeConfig.safeBlockHorizontal * 2,
                );
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
                  iconSize: SizeConfig.safeBlockHorizontal * 5,
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
