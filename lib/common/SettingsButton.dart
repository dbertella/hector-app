import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hector_app/common/SoundMixin.dart';

class SettingsButton extends StatelessWidget with Sound {
  final double iconSize;
  final VoidCallback onPressed;

  const SettingsButton({
    @required this.iconSize,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: IconButton(
        iconSize: iconSize,
        onPressed: () {
          print('button pressed');
          onPressed();
          playButtonSound();
        },
        icon: SvgPicture.asset(
          'assets/images/icons/settings.svg',
          semanticsLabel: 'Settings',
        ),
        tooltip: 'Settings',
      ),
    );
  }
}
