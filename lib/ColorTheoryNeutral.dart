import 'package:flutter/material.dart';
import 'main.dart';
import 'dart:math';
import 'ColorDetail.dart';

class ColorTheoryNeutral extends StatelessWidget {
  const ColorTheoryNeutral({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home: Scaffold(
    appBar: AppBar(title: Text('Color Picker')),
    body: Center(child: NeutralColorPickerExample()
        ),
      ),
    );
  }
}

class NeutralColorPickerExample extends StatefulWidget {
  @override
  _NeutralColorPickerExampleState createState() => _NeutralColorPickerExampleState();
}

class _NeutralColorPickerExampleState extends State<NeutralColorPickerExample> {
  Color selectedColor = Colors.grey;

  void onColorChanged(Color color) {
    setState(() {
      selectedColor = color;
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
        NeutralColorWheel(
          radius: 150,
          cursorPosition: Offset.zero,
          onColorChanged: onColorChanged,
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

class NeutralColorWheel extends StatefulWidget {
  final double radius;
  final Offset cursorPosition;
  final Function(Color) onColorChanged;

  NeutralColorWheel({
    required this.radius,
    required this.cursorPosition,
    required this.onColorChanged,
  });

  @override
  _NeutralColorWheelState createState() => _NeutralColorWheelState();
}

class _NeutralColorWheelState extends State<NeutralColorWheel> {
  Offset cursorPosition = Offset.zero;

  void updateCursorPosition(Offset position) {
    setState(() {
      cursorPosition = position;
    });
  }

  void _onPanDown(BuildContext context, DragDownDetails details) {
    RenderBox box = context.findRenderObject() as RenderBox;
    Offset localPosition = box.globalToLocal(details.globalPosition);
    _updateColorAndPosition(localPosition);
  }

  void _onPanUpdate(BuildContext context, DragUpdateDetails details) {
    RenderBox box = context.findRenderObject() as RenderBox;
    Offset localPosition = box.globalToLocal(details.globalPosition);
    _updateColorAndPosition(localPosition);
  }

  void _updateColorAndPosition(Offset localPosition) {
    final double centerX = widget.radius;
    final double centerY = widget.radius;
    final double dx = localPosition.dx - centerX;
    final double dy = localPosition.dy - centerY;
    final double distance = sqrt(dx * dx + dy * dy);

    if (distance <= widget.radius) {
      final angle = atan2(dy, dx);
      final hue = (angle + pi) / (2 * pi);
      final saturation = distance / widget.radius;

      final lerpValue = hue;
      final startColor = Colors.black;
      final endColor = HSLColor.fromAHSL(1.0, 0, saturation, (hue * 0.5) + 0.5).toColor();
      final color = Color.lerp(startColor, endColor, lerpValue);

      setState(() {
        cursorPosition = localPosition;
        widget.onColorChanged(color!);
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (details) => _onPanDown(context, details),
      onPanUpdate: (details) => _onPanUpdate(context, details),
      child: CustomPaint(
        size: Size(widget.radius * 2, widget.radius * 2),
        painter: _NeutralColorWheelPainter(
          radius: widget.radius,
          cursorPosition: cursorPosition,
        ),
      ),
    );
  }
}

class _NeutralColorWheelPainter extends CustomPainter {
  final double radius;
  final Offset cursorPosition;

  _NeutralColorWheelPainter({
    required this.radius,
    required this.cursorPosition,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < 360; i++) {
      final double angle = i * pi / 180;
      final double x = radius + radius * cos(angle);
      final double y = radius + radius * sin(angle);
      final double hue = i / 360;
      final paint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.center,
          end: Alignment(x, y),
          colors: [
            Colors.black,
            HSLColor.fromAHSL(1.0, 0, hue, (1 - hue) * 0.5 + 0.5).toColor(),
          ],
        ).createShader(
          Rect.fromCircle(
            center: Offset(radius, radius),
            radius: radius,
          ),
        );
      canvas.drawLine(
        Offset(radius, radius),
        Offset(x, y),
        paint,
      );
    }

    final cursorPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(cursorPosition, 10, cursorPaint);
  }

  @override
  bool shouldRepaint(_NeutralColorWheelPainter oldDelegate) {
    return oldDelegate.cursorPosition != cursorPosition;
  }
}



