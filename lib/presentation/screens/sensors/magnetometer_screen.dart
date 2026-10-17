import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/provider/providers.dart';

class MagnetometerScreen extends ConsumerWidget {
  const MagnetometerScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {

    // 
    final magnetometer = ref.watch(magnetomerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Magnetómetro'),
      ),
      body:  Center(
        child: magnetometer.when(
          data: (data) => Text(
             '${data.x}',
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