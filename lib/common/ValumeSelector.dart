import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:hector_app/common/AnimatedButton.dart';
import 'package:hector_app/common/SoundMixin.dart';

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

class _VolumeSelectorWidgetState extends State<VolumeSelector> with Sound {
  bool _isVolumeUp;
  Image _volumeDownImage;

  @override
  void initState() {
    super.initState();
    _isVolumeUp = widget.volume != AssetsAudioPlayer.minVolume;
    _volumeDownImage = Image.asset('assets/images/icons/volumeOff.png');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(_volumeDownImage.image, context);
  }

  @override
  void dispose() {
    super.dispose();
    disposeAudio();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: AnimatedButton(
        child: _isVolumeUp
            ? IconButton(
                iconSize: widget.iconSize,
                onPressed: () {
                  setState(() {
                    _isVolumeUp = false;
                  });
                  playButtonSound();
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
                  playButtonSound();
                  widget.onChange(AssetsAudioPlayer.maxVolume);
                },
                icon: _volumeDownImage,
                tooltip: 'Volume Up',
              ),
      ),
    );
  }
}
