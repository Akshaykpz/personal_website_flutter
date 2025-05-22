import 'dart:math';
import 'package:flutter/material.dart';

class MvNeuralWeb extends StatefulWidget {
  final int pointCount;
  final double maxDistance;
  final double canvasSize;
  final double lineThickness;
  final double speed;
  final Color dotColor;
  final Color lineColor;

  const MvNeuralWeb({
    Key? key,
    this.pointCount = 25,
    this.maxDistance = 200,
    this.canvasSize = 400,
    this.lineThickness = 2.0,
    this.speed = 1.5,
    this.dotColor = Colors.cyanAccent,
    this.lineColor = Colors.cyanAccent,
  }) : super(key: key);

  @override
  State<MvNeuralWeb> createState() => _MvNeuralWebState();
}

class _MvNeuralWebState extends State<MvNeuralWeb>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Offset> _points = [];
  final List<Offset> _velocities = [];

  @override
  void initState() {
    super.initState();
    _generatePoints();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 20))
          ..addListener(_updatePoints)
          ..repeat();
  }

  void _generatePoints() {
    final random = Random();
    for (int i = 0; i < widget.pointCount; i++) {
      _points.add(
        Offset(
          random.nextDouble() * widget.canvasSize,
          random.nextDouble() * widget.canvasSize,
        ),
      );
      _velocities.add(
        Offset(
          (random.nextDouble() - 0.5) * widget.speed * 2,
          (random.nextDouble() - 0.5) * widget.speed * 2,
        ),
      );
    }
  }

  void _updatePoints() {
    for (int i = 0; i < _points.length; i++) {
      final newPos = _points[i] + _velocities[i];

      double dx = newPos.dx;
      double dy = newPos.dy;
      double vx = _velocities[i].dx;
      double vy = _velocities[i].dy;

      if (dx <= 0 || dx >= widget.canvasSize) vx = -vx;
      if (dy <= 0 || dy >= widget.canvasSize) vy = -vy;

      _points[i] = Offset(
        dx.clamp(0, widget.canvasSize),
        dy.clamp(0, widget.canvasSize),
      );
      _velocities[i] = Offset(vx, vy);
    }

    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.canvasSize,
      height: widget.canvasSize,
      child: CustomPaint(
        painter: _MVNeuralWebPainter(
          points: _points,
          maxDistance: widget.maxDistance,
          lineThickness: widget.lineThickness,
          dotColor: widget.dotColor,
          lineColor: widget.lineColor,
        ),
      ),
    );
  }
}

class _MVNeuralWebPainter extends CustomPainter {
  final List<Offset> points;
  final double maxDistance;
  final double lineThickness;
  final Color dotColor;
  final Color lineColor;

  _MVNeuralWebPainter({
    required this.points,
    required this.maxDistance,
    required this.lineThickness,
    required this.dotColor,
    required this.lineColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paintDot = Paint()
      ..color = dotColor
      ..style = PaintingStyle.fill;

    final paintLine = Paint()..strokeWidth = lineThickness;

    for (var point in points) {
      canvas.drawCircle(point, 3, paintDot);
    }

    for (int i = 0; i < points.length; i++) {
      for (int j = i + 1; j < points.length; j++) {
        final p1 = points[i];
        final p2 = points[j];
        final distance = (p1 - p2).distance;

        if (distance < maxDistance) {
          final opacity = (1 - distance / maxDistance).clamp(0.0, 1.0);
          canvas.drawLine(
            p1,
            p2,
            paintLine..color = lineColor.withOpacity(opacity * 0.5),
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
