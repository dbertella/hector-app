// AnimatedContainer(
//           width: selected ? 200.0 : 100.0,
//           height: selected ? 100.0 : 200.0,
//           color: selected ? Colors.red : Colors.blue,
//           alignment:
//               selected ? Alignment.center : AlignmentDirectional.topCenter,
//           duration: Duration(seconds: 2),
//           curve: Curves.fastOutSlowIn,
//           child: FlutterLogo(size: 75),
//         )

import 'package:flutter/material.dart';

class AnimatedButton extends StatelessWidget {
  final Widget child;
  final double buttonSize;
  final bool selected;

  const AnimatedButton(
      {Key key,
      @required this.child,
      @required this.buttonSize,
      @required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: selected ? buttonSize : buttonSize * 0.9,
      height: selected ? buttonSize : buttonSize * 0.9,
      duration: Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
      child: child,
    );
  }
}
