import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/providers.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permisos'),
      ),
        body: const _PermissionsView(),
    );
  }
}

//  Vista de permisos para mostrar el estado actual de los permisos de la aplicación
class _PermissionsView extends ConsumerWidget {
  const _PermissionsView();

  @override
  Widget build(BuildContext context, ref) {

    final appState = ref.watch(appStateProvider);
    return ListView(
      children: [
        CheckboxListTile(
          title: const Text('Cámara'),
          subtitle: const Text('Estado actual de los permisos de la cámara'),
          value: true,
          onChanged: (value) {},
        ),
        
      ]
    );
  }
}