import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:miscelaneos/presentation/provider/providers.dart';
import 'package:miscelaneos/presentation/widgets/shared/map_layers.dart';
import 'package:miscelaneos/presentation/widgets/widgets.dart';

// Mapa con controles propios y modo seguimiento en vivo
class ControlledMapScreen extends ConsumerStatefulWidget {
  const ControlledMapScreen({super.key});

  @override
  ConsumerState<ControlledMapScreen> createState() => _ControlledMapScreenState();
}

class _ControlledMapScreenState extends ConsumerState<ControlledMapScreen> {
  final _controller = MapController();
  bool _follow = true; // Si es true la cámara sigue al usuario

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Cambia el zoom en la cantidad indicada
  void _zoom(double delta) => _controller.move(
      _controller.camera.center, _controller.camera.zoom + delta);

  @override
  Widget build(BuildContext context) {
    final initial = ref.watch(userLocationProvider);
    final live = ref.watch(watchLocationProvider);
    final colors = Theme.of(context).colorScheme;

    // Sigue al usuario cuando llega una nueva posición
    ref.listen(watchLocationProvider, (_, next) {
      final pos = next.asData?.value;
      if (_follow && pos != null) {
        _controller.move(LatLng(pos.$1, pos.$2), _controller.camera.zoom);
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Mapa guiado')),
      body: initial.when(
        loading: () => const LoadingView(),
        error: (e, _) => StateMessage(
          icon: Icons.location_off_rounded,
          title: 'No pudimos ubicarte',
          message: '$e',
          onAction: () => ref.invalidate(userLocationProvider),
        ),
        data: (d) {
          final p = live.asData?.value ?? d;
          final me = LatLng(p.$1, p.$2);
          return Stack(
            children: [
              FlutterMap(
                mapController: _controller,
                options: MapOptions(initialCenter: LatLng(d.$1, d.$2), initialZoom: 17),
                children: [
                  const MapTiles(),
                  MyLocationMarker(point: me),
                  const MapAttribution(),
                ],
              ),
              Positioned(
                right: 16,
                bottom: 40,
                child: Column(
                  children: [
                    FloatingActionButton.small(
                      heroTag: 'zoom_in',
                      onPressed: () => _zoom(1),
                      child: const Icon(Icons.add_rounded),
                    ),
                    const SizedBox(height: 8),
                    FloatingActionButton.small(
                      heroTag: 'zoom_out',
                      onPressed: () => _zoom(-1),
                      child: const Icon(Icons.remove_rounded),
                    ),
                    const SizedBox(height: 8),
                    FloatingActionButton.small(
                      heroTag: 'center',
                      onPressed: () => _controller.move(me, _controller.camera.zoom),
                      child: const Icon(Icons.my_location_rounded),
                    ),
                    const SizedBox(height: 8),
                    FloatingActionButton(
                      heroTag: 'follow',
                      tooltip: 'Seguirme',
                      backgroundColor:
                          _follow ? colors.primary : colors.surfaceContainerHighest,
                      foregroundColor: _follow ? colors.onPrimary : colors.onSurface,
                      onPressed: () {
                        setState(() => _follow = !_follow);
                        if (_follow) _controller.move(me, _controller.camera.zoom);
                      },
                      child: Icon(_follow
                          ? Icons.navigation_rounded
                          : Icons.navigation_outlined),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
