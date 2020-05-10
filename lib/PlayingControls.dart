import 'package:flutter/material.dart';

class PlayingControls extends StatelessWidget {
  final bool isPlaying;
  final Function() onPlay;

  PlayingControls({
    @required this.isPlaying,
    @required this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlatButton(
        padding: EdgeInsets.all(24),
        onPressed: this.onPlay,
        child: Icon(
          isPlaying ? Icons.pause : Icons.play_arrow,
          size: 32,
        ),
      ),
    );
  }
}
