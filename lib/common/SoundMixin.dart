import 'package:assets_audio_player/assets_audio_player.dart';

abstract class Sound {
  // This class is intended to be used as a mixin, and should not be
  // extended directly.
  factory Sound._() => null;

  void playButtonSound() {
    AssetsAudioPlayer.playAndForget(
      Audio('assets/audios/button-press.mp3'),
    );
  }
}
