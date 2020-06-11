import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hector_app/common/IconSoundButton.dart';
import 'package:hector_app/common/NavigationButton.dart';
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
  bool _isFirstPage;
  bool _isLastPage;
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
      loop: true,
      playInBackground: PlayInBackground.disabledRestoreOnForeground,
    );
  }

  @override
  void initState() {
    _pageController = PageController();
    _alignToBottom = false;
    _isFirstPage = true;
    _isLastPage = false;
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

    Widget buttonLeft = Align(
      alignment: Alignment.centerLeft,
      child: NavigationButton(
        iconTitle: 'Previous Page',
        iconPath: 'assets/images/icons/prev.svg',
        iconSize: SizeConfig.safeBlockHorizontal * 7.5,
        onPressed: () {
          if (_pageController.hasClients) {
            _pageController.previousPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          }
        },
      ),
    );

    Widget buttonRight = Align(
      alignment: Alignment.centerRight,
      child: NavigationButton(
        iconTitle: 'Next Page',
        iconPath: 'assets/images/icons/next.svg',
        iconSize: SizeConfig.safeBlockHorizontal * 7.5,
        onPressed: () {
          if (_pageController.hasClients) {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          }
        },
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: StreamBuilder(
          stream: _assetsAudioPlayer.isPlaying,
          initialData: true,
          builder: (context, asyncSnapshot) {
            final bool _isVoicePlaying = asyncSnapshot.data;
            return Stack(
              children: <Widget>[
                PageView(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    String audioPath = pages[page].skip(2).take(1).first;
                    int currentPage = _pageController.page.round();
                    setState(() {
                      _isFirstPage = currentPage == 0;
                      _isLastPage = currentPage == pages.length - 1;
                      _alignToBottom =
                          pages[page].skip(3).take(1).first == 'bottom';
                    });
                    _assetsAudioPlayer.open(
                      Audio(audioPath),
                      autoStart: true,
                      playInBackground:
                          PlayInBackground.disabledRestoreOnForeground,
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
                  child: IconSoundButton(
                    iconTitle: 'Back to home',
                    iconPath: 'assets/images/icons/home.svg',
                    iconSize: SizeConfig.safeBlockHorizontal * 5,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                _isFirstPage
                    ? SizedBox.shrink()
                    : AnimatedOpacity(
                        opacity: _isVoicePlaying ? 0.0 : 1.0,
                        duration: Duration(milliseconds: 500),
                        child: buttonLeft,
                      ),
                _isLastPage
                    ? SizedBox.shrink()
                    : AnimatedOpacity(
                        opacity: _isVoicePlaying ? 0.0 : 1.0,
                        duration: Duration(milliseconds: 500),
                        child: buttonRight,
                      ),
              ],
            );
          }),
    );
  }
}
