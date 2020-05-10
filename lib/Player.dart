// import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';

// import 'package:hector_app/PlayingControls.dart';
// import 'package:hector_app/PositionSeekWidget.dart';

// class Player extends StatefulWidget {
//   @override
//   _PlayerState createState() => _PlayerState();
// }

// class _PlayerState extends State<Player> {
//   final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
//   final List<StreamSubscription> _subscriptions = [];

//   @override
//   void initState() {
//     _subscriptions.add(_assetsAudioPlayer.playlistFinished.listen((data) {
//       print("finished : $data");
//     }));
//     _subscriptions.add(_assetsAudioPlayer.playlistAudioFinished.listen((data) {
//       print("playlistAudioFinished : $data");
//     }));
//     _subscriptions.add(_assetsAudioPlayer.current.listen((data) {
//       print("current : $data");
//     }));
//     _subscriptions.add(_assetsAudioPlayer.onReadyToPlay.listen((audio) {
//       print("onRedayToPlay : $audio");
//     }));
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _assetsAudioPlayer.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: Colors.black,
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.only(bottom: 48.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: <Widget>[
//                 SizedBox(
//                   height: 20,
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 StreamBuilder(
//                     stream: _assetsAudioPlayer.current,
//                     builder: (context, snapshot) {
//                       if (!snapshot.hasData) {
//                         return SizedBox();
//                       }
//                       final Playing playing = snapshot.data;
//                       return Column(
//                         children: <Widget>[
//                           StreamBuilder(
//                             stream: _assetsAudioPlayer.isLooping,
//                             initialData: false,
//                             builder: (context, snapshotLooping) {
//                               final bool isLooping = snapshotLooping.data;
//                               return StreamBuilder(
//                                   stream: _assetsAudioPlayer.isPlaying,
//                                   initialData: false,
//                                   builder: (context, snapshotPlaying) {
//                                     final isPlaying = snapshotPlaying.data;
//                                     return PlayingControls(
//                                       isLooping: isLooping,
//                                       isPlaying: isPlaying,
//                                       isPlaylist:
//                                           playing.playlist.audios.length > 1,
//                                       toggleLoop: () {
//                                         _assetsAudioPlayer.toggleLoop();
//                                       },
//                                       onPlay: () {
//                                         _assetsAudioPlayer.playOrPause();
//                                       },
//                                       onNext: () {
//                                         //_assetsAudioPlayer.forward(Duration(seconds: 10));
//                                         _assetsAudioPlayer.next();
//                                       },
//                                       onPrevious: () {
//                                         _assetsAudioPlayer.previous();
//                                       },
//                                     );
//                                   });
//                             },
//                           ),
//                           StreamBuilder(
//                               stream: _assetsAudioPlayer.realtimePlayingInfos,
//                               builder: (context, snapshot) {
//                                 if (!snapshot.hasData) {
//                                   return SizedBox();
//                                 }
//                                 final RealtimePlayingInfos infos =
//                                     snapshot.data;
//                                 //print("infos: $infos");
//                                 return PositionSeekWidget(
//                                   currentPosition: infos.currentPosition,
//                                   duration: infos.duration,
//                                   seekTo: (to) {
//                                     _assetsAudioPlayer.seek(to);
//                                   },
//                                 );
//                               }),
//                         ],
//                       );
//                     }),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
