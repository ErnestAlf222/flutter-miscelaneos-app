import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/provider/providers.dart';
import 'package:miscelaneos/presentation/widgets/widgets.dart';

// Aceleración del usuario en m/s² sin contar la gravedad
class AccelerometerScreen extends ConsumerWidget {
  const AccelerometerScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final accelerometer = ref.watch(accelerometerUserProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Acelerómetro')),
      body: accelerometer.when(
        data: (d) => SensorPanel(
          icon: Icons.speed_rounded,
          description: 'Mueve o sacude el teléfono para ver la fuerza en cada eje.',
          x: d.x,
          y: d.y,
          z: d.z,
          range: 10,
          unit: 'm/s²',
        ),
        loading: () => const LoadingView(),
        error: (e, _) => const StateMessage(
          icon: Icons.sensors_off_rounded,
          title: 'Sensor no disponible',
          message: 'Este dispositivo no permite leer el acelerómetro.',
        ),
      ),
    );
  }
}
