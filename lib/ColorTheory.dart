import 'package:flutter/material.dart';
import 'main.dart';
import 'dart:math';
import 'ColorDetail.dart';

class ColorTheory extends StatelessWidget {
  const ColorTheory({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home: Scaffold(
    appBar: AppBar(title: Text('Color Picker')),
    body: Center(child: ColorPicker()
        ),
      ),
    );
  }
}



class ColorPicker extends StatefulWidget {
  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  Offset cursorPosition = Offset.zero;
  Color selectedColor = Colors.red;

  void updateCursorPosition(Offset position) {
    setState(() {
      cursorPosition = position;
    });
  }

  void _onSelectColorButtonPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ColorMatches(selectedColor: selectedColor),
      ),
    );
  }

  void updateSelectedColor(Color color) {
    setState(() {
      selectedColor = color;
    });
  }

  void _onCancelPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const HomePage()
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            'Drag the cursor to pick a color: ',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ),
        SizedBox(height: 20),
        Container(
          width: 150,
          height: 50,
          color: selectedColor,
        ),
        SizedBox(height: 20),
        ColorWheel(
          radius: 150,
          holeRadius: 30,
          cursorPosition: cursorPosition,
          onCursorPositionChanged: updateCursorPosition,
          onColorChanged: updateSelectedColor,
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => _onSelectColorButtonPressed(context),
          child: Text('Select Color'),
        ),
        SizedBox(height: 10),
        TextButton(
          onPressed: () => _onCancelPressed(context),
          child: Text('Cancel', style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }
}

class ColorWheel extends StatefulWidget {
  final double radius;
  final double holeRadius;
  final Offset cursorPosition;
  final ValueChanged<Offset> onCursorPositionChanged;
  final ValueChanged<Color> onColorChanged;

  ColorWheel({
    Key? key,
    required this.radius,
    required this.holeRadius,
    required this.cursorPosition,
    required this.onCursorPositionChanged,
    required this.onColorChanged,
  }) : super(key: key);

  @override
  _ColorWheelState createState() => _ColorWheelState();
}

class _ColorWheelState extends State<ColorWheel> {
  void _onPanUpdate(BuildContext context, DragUpdateDetails details) {
    _handlePan(context, details.globalPosition);
  }

  void _onPanStart(BuildContext context, DragStartDetails details) {
    _handlePan(context, details.globalPosition);
  }

  void _handlePan(BuildContext context, Offset globalPosition) {
    RenderBox box = context.findRenderObject() as RenderBox;
    final localPosition = box.globalToLocal(globalPosition);
    final center = Offset(widget.radius, widget.radius);
    final positionVector = localPosition - center;

    if (positionVector.distance <= widget.radius /*&& positionVector.distance >= widget.holeRadius*/) {
      final angle = atan2(positionVector.dy, positionVector.dx);
      final normalizedAngle = (angle >= 0) ? angle : angle + 2 * pi;
      final hsvColor = HSVColor.fromAHSV(1.0, normalizedAngle * 180 / pi, 1.0, 1.0);
      final color = hsvColor.toColor();

      widget.onCursorPositionChanged(localPosition);
      widget.onColorChanged(color);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) => _onPanStart(context, details),
      onPanUpdate: (details) => _onPanUpdate(context, details),
      child: CustomPaint(
        size: Size(widget.radius * 2, widget.radius * 2),
        painter: ColorWheelPainter(
          radius: widget.radius,
          holeRadius: 0,//widget.holeRadius,
          cursorPosition: widget.cursorPosition,
        ),
      ),
    );
  }
}

class ColorWheelPainter extends CustomPainter {
  final double radius;
  final double holeRadius;
  final Offset cursorPosition;

  ColorWheelPainter({required this.radius, required this.holeRadius, required this.cursorPosition});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final gradient = SweepGradient(
      colors: List.generate(360, (hue) => HSVColor.fromAHSV(1.0, hue.toDouble(), 1.0, 1.0).toColor()),
    );
    final wheelPaint = Paint()
      ..shader = gradient.createShader(Rect.fromCircle(center: center, radius: radius));

    // Draw the color wheel
    canvas.drawCircle(center, radius, wheelPaint);
    // Draw the hole in the middle
    canvas.drawCircle(center, holeRadius, Paint()..color = Colors.white);

    // Draw the cursor
    final cursorPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(cursorPosition, 10, cursorPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}



