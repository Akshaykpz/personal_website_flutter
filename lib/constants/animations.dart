import 'dart:math';
import 'package:flutter/material.dart';
import 'package:my_personal_website/constants/colors.dart';

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
    this.pointCount = 32,
    this.maxDistance = 180,
    this.canvasSize = 420,
    this.lineThickness = 1.0,
    this.speed = 1.1,
    this.dotColor = AppColors.turquoise300,
    this.lineColor = AppColors.turquoise300,
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
      ..color = dotColor.withOpacity(0.86)
      ..style = PaintingStyle.fill;

    final paintLine = Paint()..strokeWidth = lineThickness;

    final glowPaint = Paint()
      ..color = lineColor.withOpacity(0.08)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18);

    for (var point in points) {
      canvas.drawCircle(point, 8, glowPaint);
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

class AnimatedTechBackground extends StatefulWidget {
  const AnimatedTechBackground({Key? key}) : super(key: key);

  @override
  State<AnimatedTechBackground> createState() => _AnimatedTechBackgroundState();
}

class _AnimatedTechBackgroundState extends State<AnimatedTechBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 16),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _TechBackgroundPainter(progress: _controller.value),
            size: Size.infinite,
          );
        },
      ),
    );
  }
}

class _TechBackgroundPainter extends CustomPainter {
  final double progress;

  _TechBackgroundPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final basePaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppColors.slateBlack,
          AppColors.slate950,
          AppColors.slateBlack,
        ],
      ).createShader(rect);
    canvas.drawRect(rect, basePaint);

    final accentPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0.58, -0.72),
        radius: 1.05,
        colors: [
          AppColors.violet900.withOpacity(0.42),
          AppColors.slateBlack.withOpacity(0),
        ],
      ).createShader(rect);
    canvas.drawRect(rect, accentPaint);

    final gridPaint = Paint()
      ..color = AppColors.slate900.withOpacity(0.24)
      ..strokeWidth = 1;
    const grid = 72.0;

    for (double x = 0; x < size.width; x += grid) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += grid) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final scanPaint = Paint()
      ..color = AppColors.turquoise300.withOpacity(0.08)
      ..strokeWidth = 1.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    final scanY = size.height * ((progress * 1.1) % 1);
    canvas.drawLine(
      Offset(0, scanY),
      Offset(size.width, scanY - size.width * 0.12),
      scanPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _TechBackgroundPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
