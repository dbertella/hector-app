import 'package:flutter/material.dart';

class PositionSeekWidget extends StatefulWidget {
  final bool isPlaying;
  final Duration currentPosition;
  final Duration duration;
  final Function(Duration) seekTo;
  final Function() setStop;

  const PositionSeekWidget({
    @required this.isPlaying,
    @required this.currentPosition,
    @required this.duration,
    @required this.seekTo,
    @required this.setStop,
  });

  @override
  _PositionSeekWidgetState createState() => _PositionSeekWidgetState();
}

class _PositionSeekWidgetState extends State<PositionSeekWidget> {
  Duration _visibleValue;
  bool listenOnlyUserInterraction = false;
  double get percent => widget.duration.inMilliseconds == 0
      ? 0
      : _visibleValue.inMilliseconds / widget.duration.inMilliseconds;

  @override
  void initState() {
    super.initState();
    _visibleValue = widget.currentPosition;
  }

  @override
  void didUpdateWidget(PositionSeekWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listenOnlyUserInterraction) {
      _visibleValue = widget.currentPosition;
    }
    if (widget.currentPosition.inMilliseconds ==
            widget.duration.inMilliseconds &&
        widget.isPlaying) {
      print('stop');
      print(widget.isPlaying);
      print(widget.currentPosition.inMilliseconds);
      print(widget.duration.inMilliseconds);
      widget.setStop();
      _visibleValue = Duration(milliseconds: 0); // this doesn't work tonight
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Container(
            child: Slider(
              min: 0,
              max: widget.duration.inMilliseconds.toDouble(),
              value: percent * widget.duration.inMilliseconds.toDouble(),
              onChangeEnd: (newValue) {
                setState(() {
                  listenOnlyUserInterraction = false;
                  widget.seekTo(_visibleValue);
                });
              },
              onChangeStart: (_) {
                setState(() {
                  listenOnlyUserInterraction = true;
                });
              },
              onChanged: (newValue) {
                setState(() {
                  final to = Duration(milliseconds: newValue.floor());
                  _visibleValue = to;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
