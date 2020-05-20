import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class VolumeSelector extends StatefulWidget {
  final double volume;
  final Function(double) onChange;

  const VolumeSelector({
    @required this.volume,
    @required this.onChange,
  });

  @override
  _VolumeSelectorWidgetState createState() => _VolumeSelectorWidgetState();
}

class _VolumeSelectorWidgetState extends State<VolumeSelector> {
  bool _isVolumeUp;

  @override
  void initState() {
    super.initState();
    _isVolumeUp = widget.volume != AssetsAudioPlayer.minVolume;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: _isVolumeUp
          ? IconButton(
              onPressed: () {
                setState(() {
                  _isVolumeUp = false;
                });
                widget.onChange(AssetsAudioPlayer.minVolume);
              },
              icon: Image.asset('assets/images/icons/volumeOn.png'),
              tooltip: 'Volume Mute',
            )
          : IconButton(
              onPressed: () {
                setState(() {
                  _isVolumeUp = true;
                });
                widget.onChange(AssetsAudioPlayer.maxVolume);
              },
              icon: Image.asset('assets/images/icons/volumeOff.png'),
              tooltip: 'Volume Up',
            ),
    );
  }
}
