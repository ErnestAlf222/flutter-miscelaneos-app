import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/provider/providers.dart';



class GyroscopeScreen extends ConsumerWidget {
  const GyroscopeScreen({super.key});

  @override
  Widget build(BuildContext context, ref ) {

    final gyroscope = ref.watch(gyroscopeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Giroscopio'),
      ),
      body:  Center(
        child: gyroscope.when(
          data: (data) => Text(
            'Giroscopio:\nX: ${data.x}\nY: ${data.y}\nZ: ${data.z}',
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