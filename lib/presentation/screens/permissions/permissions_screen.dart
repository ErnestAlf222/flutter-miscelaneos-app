import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../provider/providers.dart';

class PermissionsScreen extends ConsumerStatefulWidget {
  const PermissionsScreen({super.key});

  @override
  ConsumerState<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends ConsumerState<PermissionsScreen> {
  @override
  void initState() {
    super.initState();
    // Refresca el estado real al entrar
    Future.microtask(() => ref.read(permissionsProvider.notifier).checkPermissions());
  }

  @override
  Widget build(BuildContext context) {
    final p = ref.watch(permissionsProvider);
    final n = ref.read(permissionsProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Permisos')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Activa solo lo que necesites. Puedes cambiarlo cuando quieras.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 16),
          _PermissionTile(
            icon: Icons.photo_camera_rounded,
            title: 'Cámara',
            description: 'Tomar fotos y escanear.',
            status: p.camera,
            onRequest: n.requestCameraAccess,
          ),
          _PermissionTile(
            icon: Icons.photo_library_rounded,
            title: 'Galería',
            description: 'Elegir fotos guardadas.',
            status: p.photoLibrary,
            onRequest: n.requestPhotoLibraryAccess,
          ),
          _PermissionTile(
            icon: Icons.location_on_rounded,
            title: 'Ubicación',
            description: 'Brújula, mapas y posición.',
            status: p.location,
            onRequest: n.requestLocationAccess,
          ),
          _PermissionTile(
            icon: Icons.sensors_rounded,
            title: 'Sensores',
            description: 'Lecturas del cuerpo y movimiento.',
            status: p.sensors,
            onRequest: n.requestSensorsAccess,
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: n.openSettingsScreen,
            icon: const Icon(Icons.settings_rounded),
            label: const Text('Abrir ajustes del sistema'),
            style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(52)),
          ),
        ],
      ),
    );
  }
}

class _PermissionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final PermissionStatus? status;
  final VoidCallback onRequest;

  const _PermissionTile({
    required this.icon,
    required this.title,
    required this.description,
    required this.status,
    required this.onRequest,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final granted = status == PermissionStatus.granted;
    final blocked = status == PermissionStatus.permanentlyDenied;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: granted ? Colors.green.withValues(alpha: 0.15) : colors.primaryContainer,
            child: Icon(icon, color: granted ? Colors.green : colors.onPrimaryContainer),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                Text(description, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: colors.onSurfaceVariant)),
              ],
            ),
          ),
          granted
              ? const Chip(
                  label: Text('Activo'),
                  avatar: Icon(Icons.check_circle_rounded, color: Colors.green, size: 18),
                )
              : FilledButton.tonal(
                  style: FilledButton.styleFrom(minimumSize: const Size(90, 40)),
                  onPressed: onRequest,
                  child: Text(blocked ? 'Ajustes' : 'Permitir'),
                ),
        ],
      ),
    );
  }
}
