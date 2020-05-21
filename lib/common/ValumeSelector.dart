import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_svg/svg.dart';
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

  @override
  void initState() {
    super.initState();
    _isVolumeUp = widget.volume != AssetsAudioPlayer.minVolume;
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
                icon: SvgPicture.asset(
                  'assets/images/icons/volumeOn.svg',
                  semanticsLabel: 'Volume Mute',
                ),
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
                // icon: _volumeDownImage,
                icon: SvgPicture.asset(
                  'assets/images/icons/volumeOff.svg',
                  semanticsLabel: 'Volume Up',
                ),
                tooltip: 'Volume Up',
              ),
      ),
    );
  }
}
