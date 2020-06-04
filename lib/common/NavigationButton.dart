import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavigationButton extends StatelessWidget {
  final String iconTitle;
  final String iconPath;
  final double iconSize;
  final VoidCallback onPressed;

  const NavigationButton({
    @required this.iconTitle,
    @required this.iconPath,
    @required this.iconSize,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: IconButton(
        iconSize: iconSize,
        onPressed: onPressed,
        icon: SvgPicture.asset(
          iconPath,
          semanticsLabel: iconTitle,
        ),
        tooltip: iconTitle,
      ),
    );
  }
}
