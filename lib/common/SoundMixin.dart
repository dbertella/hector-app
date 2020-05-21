import 'package:assets_audio_player/assets_audio_player.dart';

abstract class Sound {
  // This class is intended to be used as a mixin, and should not be
  // extended directly.
  factory Sound._() => null;

  final _assetsAudioPlayer = AssetsAudioPlayer();

  void disposeAudio() {
    _assetsAudioPlayer.dispose();
  }

  void playButtonSound() {
    _assetsAudioPlayer.open(
      Audio('assets/audios/button-press.mp3'),
    );
    _assetsAudioPlayer.play();
  }
}
