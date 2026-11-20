import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/provider/providers.dart';
import 'package:miscelaneos/presentation/widgets/widgets.dart';

// Campo magnético en microteslas (µT)
class MagnetometerScreen extends ConsumerWidget {
  const MagnetometerScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final magnetometer = ref.watch(magnetomerProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Magnetómetro')),
      body: magnetometer.when(
        data: (d) => SensorPanel(
          icon: Icons.compass_calibration_rounded,
          description: 'Acerca un imán o metal para ver cómo cambia el campo magnético.',
          x: d.x,
          y: d.y,
          z: d.z,
          range: 100,
          unit: 'µT',
        ),
        loading: () => const LoadingView(),
        error: (e, _) => const StateMessage(
          icon: Icons.sensors_off_rounded,
          title: 'Sensor no disponible',
          message: 'Este dispositivo no permite leer el magnetómetro.',
        ),
      ),
    );
  }
}
