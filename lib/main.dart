import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hector_app/PageSlide.dart';
import 'package:hector_app/PlayingControls.dart';
import 'package:hector_app/PositionSeekWidget.dart';
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
                ).toList()),
            Align(
              alignment: Alignment.topRight,
              child: StreamBuilder(
                  stream: _assetsAudioPlayer.current,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return SizedBox();
                    }
                    return StreamBuilder(
                      stream: _assetsAudioPlayer.isPlaying,
                      initialData: false,
                      builder: (context, snapshotPlaying) {
                        final isPlaying = snapshotPlaying.data;
                        return Row(
                          children: <Widget>[
                            PlayingControls(
                              isPlaying: isPlaying,
                              onPlay: () {
                                _assetsAudioPlayer.playOrPause();
                              },
                            ),
                            StreamBuilder(
                              stream: _assetsAudioPlayer.realtimePlayingInfos,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return SizedBox();
                                }
                                final RealtimePlayingInfos infos =
                                    snapshot.data;
                                return PositionSeekWidget(
                                    isPlaying: isPlaying,
                                    currentPosition: infos.currentPosition,
                                    duration: infos.duration,
                                    seekTo: (to) {
                                      _assetsAudioPlayer.seek(to);
                                    },
                                    setStop: () {
                                      _assetsAudioPlayer.stop();
                                    });
                              },
                            )
                          ],
                        );
                      },
                    );
                  }),
            ),
            Align(
                // alignment: Alignment.topRight,
                // child: StreamBuilder(
                //     stream: _assetsAudioPlayer.current,
                //     builder: (context, snapshot) {
                //       if (!snapshot.hasData) {
                //         return SizedBox();
                //       }
                //       return ;
                //     }),
                // SizedBox(
                //   height: 20,
                // ),
                // StreamBuilder(
                //     stream: _assetsAudioPlayer.current,
                //     builder: (
                //       BuildContext context,
                //       AsyncSnapshot<Playing> snapshot,
                //     ) {
                //       final Playing playing = snapshot.data;
                //       print(playing);
                //       if (playing != null) {
                //         return FlatButton(
                //           onPressed: () {
                //             _assetsAudioPlayer.stop();
                //           },
                //           child: Icon(Icons.pause_circle_outline),
                //         );
                //       }
                //       return FlatButton(
                //         onPressed: () {
                //           _assetsAudioPlayer.play();
                //         },
                //         child: Icon(Icons.play_circle_outline),
                //       );
                //     })
                ),
            Align(
              alignment: Alignment.topLeft,
              child: Row(
                children: <Widget>[
                  FlatButton(
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
                    ),
                  ),
                  // Text(_pageController.page.round().toString() +
                  //     '/' +
                  //     pages.length.toString()),
                  // FlatButton(
                  //   onPressed: () {
                  //     if (_pageController.hasClients) {
                  //       _pageController.animateToPage(
                  //         // _pageController.page.round() + 1,
                  //         pages.length,
                  //         duration: const Duration(milliseconds: 400),
                  //         curve: Curves.easeInOut,
                  //       );
                  //     }
                  //   },
                  //   child: Text(
                  //     "Last",
                  //   ),
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
