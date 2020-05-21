import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class VolumeSelector extends StatefulWidget {
  final double volume;
  final double iconSize;
  final Function(double) onChange;

  const VolumeSelector({
    @required this.volume,
    @required this.iconSize,
    @required this.onChange,
  });

  @override
  _VolumeSelectorWidgetState createState() => _VolumeSelectorWidgetState();
}

class _VolumeSelectorWidgetState extends State<VolumeSelector> {
  bool _isVolumeUp;

  final _assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    _isVolumeUp = widget.volume != AssetsAudioPlayer.minVolume;
  }

  @override
  void dispose() {
    _assetsAudioPlayer.dispose();
    super.dispose();
  }

  void _playButtonSound() {
    _assetsAudioPlayer.open(
      Audio('assets/audios/button-press.mp3'),
    );
    _assetsAudioPlayer.play();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: _isVolumeUp
          ? IconButton(
              iconSize: widget.iconSize,
              onPressed: () {
                setState(() {
                  _isVolumeUp = false;
                });
                _playButtonSound();
                widget.onChange(AssetsAudioPlayer.minVolume);
              },
              icon: Image.asset('assets/images/icons/volumeOn.png'),
              tooltip: 'Volume Mute',
            )
          : IconButton(
              iconSize: widget.iconSize,
              onPressed: () {
                setState(() {
                  _isVolumeUp = true;
                });
                _playButtonSound();
                widget.onChange(AssetsAudioPlayer.maxVolume);
              },
              icon: Image.asset('assets/images/icons/volumeOff.png'),
              tooltip: 'Volume Up',
            ),
    );
  }
}
