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
  bool _alignToBottom;

  final double volumeBg = 0.05;

  _StoryState() {
    _assetsAudioPlayer.open(
      Audio('assets/audios/cover.mp3'),
      autoStart: true,
      playInBackground: PlayInBackground.disabledRestoreOnForeground,
    );

    _assetsAudioPlayerBg.open(
      Audio('assets/audios/bgMusic.mp3'),
      volume: volumeBg,
      autoStart: true,
      playInBackground: PlayInBackground.disabledRestoreOnForeground,
    );
    _assetsAudioPlayerBg.loop = true;
  }

  @override
  void initState() {
    _pageController = PageController();
    _alignToBottom = false;
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
              setState(() {
                _alignToBottom = pages[page].skip(3).take(1).first == 'bottom';
              });

              _assetsAudioPlayer.open(
                Audio(audioPath),
                autoStart: true,
                playInBackground: PlayInBackground.disabledRestoreOnForeground,
              );
            },
            children: pages.map(
              (content) {
                return PageSlide(
                  path: content.take(1).first,
                  text: content.skip(1).take(1).first,
                  fontSize: SizeConfig.safeBlockHorizontal * 2,
                  alignToBottom: _alignToBottom,
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
                    _assetsAudioPlayerBg.setVolume(
                        AssetsAudioPlayer.maxVolume == v ? volumeBg : v);
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
