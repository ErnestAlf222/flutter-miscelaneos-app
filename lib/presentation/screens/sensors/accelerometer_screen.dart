import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/provider/providers.dart';

class AccelerometerScreen extends ConsumerWidget {
  const AccelerometerScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final accelerometer = ref.watch(accelerometerUserProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acelerómetro'),
      ),
      body: Center(
        child: accelerometer.when(
          data: (data) => Text(
            'Acelerometro usuario:\nX: ${data.x}\nY: ${data.y}\nZ: ${data.z}',
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) => Text('Error: $error'),
        ),
      ),
    );
  }
}
