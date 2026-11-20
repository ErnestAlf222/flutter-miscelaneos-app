import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:miscelaneos/presentation/provider/providers.dart';
import 'package:miscelaneos/presentation/widgets/widgets.dart';

// Pantalla previa que pide el permiso de ubicación
class AskLocationScreen extends ConsumerWidget {
  const AskLocationScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Permiso requerido')),
      body: StateMessage(
        icon: Icons.location_on_rounded,
        title: 'Necesitamos tu ubicación',
        message: 'La brújula usa la ubicación para calcular el norte con precisión.',
        actionLabel: 'Permitir ubicación',
        onAction: () => ref.read(permissionsProvider.notifier).requestLocationAccess(),
      ),
    );
  }
}
