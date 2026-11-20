import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/provider/providers.dart';
import 'package:miscelaneos/presentation/widgets/widgets.dart';

// Nivel: la bola rueda hacia donde inclinas el teléfono
class GyroscopeBallScreen extends ConsumerWidget {
  const GyroscopeBallScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final gravity = ref.watch(accelerometerGravityProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Nivel')),
      body: gravity.when(
        // Se invierte el eje horizontal para que la bola ruede al inclinar
        data: (v) => _Level(dx: -v.y / 6, dy: v.x / 6),
        loading: () => const LoadingView(),
        error: (e, _) => const StateMessage(
          icon: Icons.sensors_off_rounded,
          title: 'Sensor no disponible',
          message: 'Este dispositivo no permite leer la inclinación.',
        ),
      ),
    );
  }
}

class _Level extends StatelessWidget {
  final double dx; // -1 a 1
  final double dy; // -1 a 1

  const _Level({required this.dx, required this.dy});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final x = dx.clamp(-1.0, 1.0);
    final y = dy.clamp(-1.0, 1.0);
    // Equilibrado si la inclinación es mínima
    final balanced = x.abs() < 0.06 && y.abs() < 0.06;
    final tone = balanced ? Colors.green : colors.primary;

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  margin: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors.surfaceContainerLow,
                    border: Border.all(color: tone.withValues(alpha: 0.5), width: 3),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Mira central
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: colors.outline, width: 1.5),
                        ),
                      ),
                      Container(width: 1.5, height: double.infinity, color: colors.outlineVariant),
                      Container(height: 1.5, width: double.infinity, color: colors.outlineVariant),
                      AnimatedAlign(
                        alignment: Alignment(x * 0.85, y * 0.85),
                        duration: const Duration(milliseconds: 150),
                        curve: Curves.easeOut,
                        child: Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [Colors.white.withValues(alpha: 0.6), tone],
                              center: const Alignment(-0.3, -0.3),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: tone.withValues(alpha: 0.4),
                                blurRadius: 16,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: Text(
              balanced ? '¡Nivelado!' : 'Inclina el teléfono',
              style: text.titleMedium?.copyWith(color: tone, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
