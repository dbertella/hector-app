import 'package:flutter/material.dart';
import 'package:hector_app/common/IconSoundButton.dart';
import 'package:hector_app/common/OnlyOnePointerRecognizer.dart';
import 'package:hector_app/common/SizeConfig.dart';

class WriteScreen extends StatefulWidget {
  static String routeName = '/games';

  @override
  _WriteScreenState createState() => _WriteScreenState();
}

class KanjiPainter extends ChangeNotifier implements CustomPainter {
  var strokes = List<List<Offset>>();

  KanjiPainter();

  bool hitTest(Offset position) => null;

  void startStroke(Offset position) {
    print("startStroke");
    strokes.add([position]);
    notifyListeners();
  }

  void appendStroke(Offset position) {
    print("appendStroke");
    var stroke = strokes.last;
    stroke.add(position);
    notifyListeners();
  }

  void endStroke() {
    notifyListeners();
  }

  @override
  void paint(Canvas canvas, Size size) {
    print("paint!");
    var rect = Offset.zero & size;
    Paint fillPaint = Paint();
    fillPaint.color = Colors.transparent;
    // fillPaint.style = PaintingStyle.fill;
    canvas.drawRect(rect, fillPaint);

    Paint strokePaint = Paint();
    strokePaint.color = Color(0xffBD8AE6);
    strokePaint.strokeWidth = 12;
    strokePaint.style = PaintingStyle.stroke;

    for (var stroke in strokes) {
      Path strokePath = Path();
      // Iterator strokeIt = stroke.iterator..moveNext();
      // Offset start = strokeIt.current;
      // strokePath.moveTo(start.dx, start.dy);
      // while (strokeIt.moveNext()) {
      //   Offset off = strokeIt.current;
      //   strokePath.addP
      // }
      strokePath.addPolygon(stroke, false);
      canvas.drawPath(strokePath, strokePaint);
    }
  }

  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  @override
  // TODO: implement semanticsBuilder
  get semanticsBuilder => null;

  @override
  bool shouldRebuildSemantics(CustomPainter oldDelegate) {
    // TODO: implement shouldRebuildSemantics
    return false;
  }
}

class _WriteScreenState extends State<WriteScreen> {
  GestureDetector touch;
  CustomPaint canvas;
  KanjiPainter kanjiPainter;

  void panStart(DragStartDetails details) {
    print(details.globalPosition);
    kanjiPainter.startStroke(details.globalPosition);
  }

  void panUpdate(DragUpdateDetails details) {
    print(details.globalPosition);
    kanjiPainter.appendStroke(details.globalPosition);
    if (details.globalPosition == Offset(620, 70)) {
      print('OK');
    }
  }

  void panEnd(DragEndDetails details) {
    kanjiPainter.endStroke();
  }

  @override
  void initState() {
    super.initState();
    kanjiPainter = KanjiPainter();
  }

  @override
  Widget build(BuildContext context) {
    touch = GestureDetector(
      onPanStart: panStart,
      onPanUpdate: panUpdate,
      onPanEnd: panEnd,
    );

    canvas = CustomPaint(
      painter: kanjiPainter,
      child: touch,
    );

    SizeConfig().init(context);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            // padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/HectorMaze.png'),
                fit: BoxFit.contain,
              ),
            ),
            child: OnlyOnePointerRecognizerWidget(child: canvas),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: IconSoundButton(
              iconTitle: 'Back to home',
              iconPath: 'assets/images/icons/home.svg',
              iconSize: SizeConfig.safeBlockHorizontal * 5,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
