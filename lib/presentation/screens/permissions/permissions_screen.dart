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

    final permissions = ref.watch(permissionsProvider);
    return ListView(
      children: [
        CheckboxListTile(
          title:  const Text('Cámara'),
          subtitle:  Text('${permissions.camera}'),
          value: permissions.cameraGranted,
          onChanged: (_) {
            // Se solicita el permiso de la cámara y se actualiza el estado de los permisos de la aplicación con el estado del permiso obtenido
            ref.read(permissionsProvider.notifier).requestCameraAccess();

          },
        ),
        CheckboxListTile(
          title:  const Text('Galería de fotos'),
          subtitle:  Text('${permissions.photoLibrary}'),
          value: permissions.photoLibraryGranted,
          onChanged: (_) {
            ref.read(permissionsProvider.notifier).requestPhotoLibraryAccess();

          },
        ),
        CheckboxListTile(
          title:  const Text('Ubicación'),
          subtitle:  Text('${permissions.location}'),
          value: permissions.locationGranted,
          onChanged: (_) {
            ref.read(permissionsProvider.notifier).requestLocationAccess();

          },
        ),
        CheckboxListTile(
          title:  const Text('Sensors'),
          subtitle:  Text('${permissions.sensors}'),
          value: permissions.sensorsGranted,
          onChanged: (_) {
            ref.read(permissionsProvider.notifier).requestSensorsAccess();

          },
        ),  
      ]
    );
  }
}
