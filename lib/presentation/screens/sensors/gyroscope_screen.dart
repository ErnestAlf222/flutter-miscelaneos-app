import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/provider/providers.dart';
import 'package:miscelaneos/presentation/widgets/widgets.dart';

// Velocidad de rotación en rad/s
class GyroscopeScreen extends ConsumerWidget {
  const GyroscopeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final gyroscope = ref.watch(gyroscopeProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Giroscopio')),
      body: gyroscope.when(
        data: (d) => SensorPanel(
          icon: Icons.downloading_rounded,
          description: 'Gira el teléfono para ver qué tan rápido rota en cada eje.',
          x: d.x,
          y: d.y,
          z: d.z,
          range: 5,
          unit: 'rad/s',
        ),
        loading: () => const LoadingView(),
        error: (e, _) => const StateMessage(
          icon: Icons.sensors_off_rounded,
          title: 'Sensor no disponible',
          message: 'Este dispositivo no permite leer el giroscopio.',
        ),
      ),
    );
  }
}
