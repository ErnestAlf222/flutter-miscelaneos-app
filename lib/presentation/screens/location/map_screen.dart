import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:miscelaneos/presentation/provider/providers.dart';
import 'package:miscelaneos/presentation/widgets/shared/map_layers.dart';
import 'package:miscelaneos/presentation/widgets/widgets.dart';

// Mapa centrado en tu ubicación; mantén pulsado para marcar puntos
class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  final _controller = MapController();
  final List<LatLng> _points = [];
  bool _satellite = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final location = ref.watch(userLocationProvider);
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
        actions: [
          // Alterna entre vista normal y satélite
          IconButton(
            tooltip: 'Tipo de mapa',
            icon: Icon(_satellite ? Icons.map_outlined : Icons.satellite_alt_rounded),
            onPressed: () => setState(() => _satellite = !_satellite),
          ),
          if (_points.isNotEmpty)
            IconButton(
              tooltip: 'Borrar puntos',
              icon: const Icon(Icons.layers_clear_rounded),
              onPressed: () => setState(_points.clear),
            ),
        ],
      ),
      body: location.when(
        loading: () => const LoadingView(),
        error: (e, _) => StateMessage(
          icon: Icons.location_off_rounded,
          title: 'No pudimos ubicarte',
          message: '$e',
          onAction: () => ref.invalidate(userLocationProvider),
        ),
        data: (d) {
          final me = LatLng(d.$1, d.$2);
          return Stack(
            children: [
              FlutterMap(
                mapController: _controller,
                options: MapOptions(
                  initialCenter: me,
                  initialZoom: 16,
                  onLongPress: (_, p) => setState(() => _points.add(p)),
                ),
                children: [
                  MapTiles(satellite: _satellite),
                  MarkerLayer(markers: [
                    for (final p in _points)
                      Marker(
                        point: p,
                        width: 40,
                        height: 40,
                        alignment: Alignment.topCenter,
                        child: Icon(Icons.location_on_rounded,
                            color: colors.error, size: 40),
                      ),
                  ]),
                  MyLocationMarker(point: me),
                  MapAttribution(satellite: _satellite),
                ],
              ),
              Positioned(
                right: 16,
                bottom: 40,
                child: FloatingActionButton(
                  heroTag: 'me',
                  tooltip: 'Mi ubicación',
                  onPressed: () => _controller.move(me, 16),
                  child: const Icon(Icons.my_location_rounded),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
