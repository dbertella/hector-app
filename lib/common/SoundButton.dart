import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class SoundButton extends StatefulWidget {
  final Widget child;

  const SoundButton({Key key, this.child}) : super(key: key);

  @override
  _SoundButtonState createState() => _SoundButtonState();
}

class _SoundButtonState extends State<SoundButton> {
  final _assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void dispose() {
    _assetsAudioPlayer.dispose();
    super.dispose();
  }

  void _onTap() {
    _assetsAudioPlayer.open(
      Audio('assets/audios/button-press.mp3'),
    );
    _assetsAudioPlayer.play();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: widget.child,
    );
  }
}
