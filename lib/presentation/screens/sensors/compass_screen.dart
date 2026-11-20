import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/config/config.dart';
import 'package:miscelaneos/presentation/provider/providers.dart';
import 'package:miscelaneos/presentation/screens/screens.dart';
import 'package:miscelaneos/presentation/widgets/widgets.dart';

class CompassScreen extends ConsumerWidget {
  const CompassScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final locationGranted = ref.watch(permissionsProvider).locationGranted;
    final compassHeading = ref.watch(compassProvider);

    if (!locationGranted) return const AskLocationScreen();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Brújula', style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0B0B1A), Color(0xFF1E1B4B), Color(0xFF3B0764)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: compassHeading.when(
          data: (data) => CompassView(heading: data ?? 0),
          loading: () => const LoadingView(),
          error: (e, _) => const StateMessage(
            icon: Icons.sensors_off_rounded,
            title: 'Brújula no disponible',
            message: 'Este dispositivo no tiene sensor de orientación.',
          ),
        ),
      ),
    );
  }
}

// Brújula dibujada a mano: siempre centrada y sin imágenes externas
class CompassView extends StatefulWidget {
  final double heading;
  const CompassView({super.key, required this.heading});

  @override
  State<CompassView> createState() => _CompassViewState();
}

class _CompassViewState extends State<CompassView> {
  late double _angle = _norm(widget.heading); // Ángulo acumulado sin saltos

  static double _norm(double d) => ((d % 360) + 360) % 360;

  @override
  void didUpdateWidget(CompassView old) {
    super.didUpdateWidget(old);
    // Gira por el camino más corto (evita el salto 359° → 0°)
    final delta = ((_norm(widget.heading) - _norm(_angle)) + 540) % 360 - 180;
    _angle += delta;
  }

  // Punto cardinal según los grados
  String get _cardinal {
    const names = ['N', 'NE', 'E', 'SE', 'S', 'SO', 'O', 'NO'];
    return names[((_norm(widget.heading) + 22.5) ~/ 45) % 8];
  }

  @override
  Widget build(BuildContext context) {
    final degrees = _norm(widget.heading).round() % 360;
    return SafeArea(
      child: Column(
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: AspectRatio(
              aspectRatio: 1,
              child: TweenAnimationBuilder<double>(
                tween: Tween(end: _angle),
                duration: const Duration(milliseconds: 250),
                builder: (_, a, __) => CustomPaint(painter: _CompassPainter(a)),
              ),
            ),
          ),
          const SizedBox(height: 28),
          Text(
            '$degrees°',
            style: const TextStyle(
                color: Colors.white, fontSize: 56, fontWeight: FontWeight.w700, height: 1),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
            decoration: BoxDecoration(
              gradient: AppTheme.brandGradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(_cardinal,
                style: const TextStyle(
                    color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600)),
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.fromLTRB(32, 0, 32, 24),
            child: Text(
              'Mueve el teléfono en forma de 8 si la lectura parece imprecisa.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white60, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _CompassPainter extends CustomPainter {
  final double angle; // Grados del rumbo
  _CompassPainter(this.angle);

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    final outer = size.width / 2;
    final r = outer - 16; // Radio del disco
    final rect = Rect.fromCircle(center: c, radius: r);

    // Disco con degradado y borde luminoso
    canvas.drawCircle(
      c,
      r,
      Paint()
        ..shader = const RadialGradient(
          colors: [Color(0xFF312E81), Color(0xFF0F0A2E)],
        ).createShader(rect),
    );
    canvas.drawCircle(
      c,
      r,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..shader = SweepGradient(colors: AppTheme.brandColors + [AppTheme.brandColors[0]])
            .createShader(rect),
    );

    // Disco que gira con el rumbo
    canvas.save();
    canvas.translate(c.dx, c.dy);
    canvas.rotate(-angle * math.pi / 180);

    final tick = Paint()..strokeCap = StrokeCap.round;
    for (var deg = 0; deg < 360; deg += 5) {
      final major = deg % 30 == 0;
      final mid = deg % 10 == 0;
      final len = major ? 16.0 : (mid ? 10.0 : 6.0);
      tick
        ..color = major ? Colors.white : Colors.white38
        ..strokeWidth = major ? 2.5 : 1.5;
      canvas.save();
      canvas.rotate(deg * math.pi / 180);
      canvas.drawLine(Offset(0, -(r - 8)), Offset(0, -(r - 8 - len)), tick);
      canvas.restore();
    }

    // Letras cardinales y números cada 30°
    const cardinals = {0: 'N', 90: 'E', 180: 'S', 270: 'O'};
    for (var deg = 0; deg < 360; deg += 30) {
      final isCard = cardinals.containsKey(deg);
      _label(
        canvas,
        isCard ? cardinals[deg]! : '$deg',
        deg,
        isCard ? r - 52 : r - 40,
        isCard ? 28 : 12,
        deg == 0 ? const Color(0xFFFF4D6D) : (isCard ? Colors.white : Colors.white60),
        isCard ? FontWeight.w700 : FontWeight.w400,
      );
    }
    canvas.restore();

    // Aguja fija: norte en rojo, sur en blanco
    final north = Path()
      ..moveTo(c.dx, c.dy - r * 0.42)
      ..lineTo(c.dx - 9, c.dy)
      ..lineTo(c.dx + 9, c.dy)
      ..close();
    final south = Path()
      ..moveTo(c.dx, c.dy + r * 0.42)
      ..lineTo(c.dx - 9, c.dy)
      ..lineTo(c.dx + 9, c.dy)
      ..close();
    canvas.drawPath(north, Paint()..color = const Color(0xFFFF4D6D));
    canvas.drawPath(south, Paint()..color = Colors.white70);
    canvas.drawCircle(c, 6, Paint()..color = Colors.white);

    // Marcador superior fijo (hacia dónde apunta el teléfono)
    final pointer = Path()
      ..moveTo(c.dx - 10, c.dy - outer + 1)
      ..lineTo(c.dx + 10, c.dy - outer + 1)
      ..lineTo(c.dx, c.dy - outer + 19)
      ..close();
    canvas.drawPath(pointer, Paint()..color = Colors.white);
  }

  // Dibuja un texto en el disco rotado `deg` a una distancia del centro
  void _label(Canvas canvas, String s, int deg, double dist, double fontSize,
      Color color, FontWeight weight) {
    final tp = TextPainter(
      text: TextSpan(
          text: s,
          style: TextStyle(color: color, fontSize: fontSize, fontWeight: weight)),
      textDirection: TextDirection.ltr,
    )..layout();
    canvas.save();
    canvas.rotate(deg * math.pi / 180);
    canvas.translate(0, -dist);
    tp.paint(canvas, Offset(-tp.width / 2, -tp.height / 2));
    canvas.restore();
  }

  @override
  bool shouldRepaint(_CompassPainter old) => old.angle != angle;
}
