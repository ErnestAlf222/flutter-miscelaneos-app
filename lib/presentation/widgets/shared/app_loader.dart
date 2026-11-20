import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:miscelaneos/config/config.dart';

// Cargador propio: anillo con degradado que gira y un punto que late
class AppLoader extends StatefulWidget {
  final double size;
  const AppLoader({super.key, this.size = 56});

  @override
  State<AppLoader> createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader> with SingleTickerProviderStateMixin {
  late final AnimationController _c =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 1400))..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _c,
        builder: (_, __) => CustomPaint(painter: _RingPainter(_c.value)),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double t;
  _RingPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final r = size.width / 2 - 4;
    final rect = Rect.fromCircle(center: c, radius: r);

    // Anillo con degradado giratorio
    final ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.09
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        colors: [AppTheme.brandColors[0].withValues(alpha: 0), ...AppTheme.brandColors],
        transform: GradientRotation(t * 2 * math.pi),
      ).createShader(rect);
    canvas.drawArc(rect, t * 2 * math.pi, math.pi * 1.5, false, ring);

    // Punto central que late
    final pulse = 0.6 + 0.4 * math.sin(t * 2 * math.pi).abs();
    canvas.drawCircle(
      c,
      size.width * 0.12 * pulse,
      Paint()..color = AppTheme.brandColors[1],
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) => old.t != t;
}
