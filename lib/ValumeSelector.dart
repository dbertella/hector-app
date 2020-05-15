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
      padding: const EdgeInsets.all(8.0),
      child: _isVolumeUp
          ? FlatButton(
              padding: EdgeInsets.all(16),
              onPressed: () {
                setState(() {
                  _isVolumeUp = false;
                });
                widget.onChange(AssetsAudioPlayer.minVolume);
              },
              child: Icon(
                Icons.volume_up,
                size: 32,
                color: Colors.grey[800],
              ),
            )
          : FlatButton(
              padding: EdgeInsets.all(16),
              onPressed: () {
                setState(() {
                  _isVolumeUp = true;
                });
                widget.onChange(AssetsAudioPlayer.maxVolume);
              },
              child: Icon(
                Icons.volume_mute,
                size: 32,
                color: Colors.grey[800],
              ),
            ),
    );
  }
}
