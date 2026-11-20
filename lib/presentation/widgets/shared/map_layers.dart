import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

// Capas comunes de los mapas (OpenStreetMap, sin API key)
class MapTiles extends StatelessWidget {
  final bool satellite;
  const MapTiles({super.key, this.satellite = false});

  @override
  Widget build(BuildContext context) {
    return TileLayer(
      urlTemplate: satellite
          ? 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}'
          : 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'com.miscelaneos.app',
    );
  }
}

// Punto azul que marca tu posición
class MyLocationMarker extends StatelessWidget {
  final LatLng point;
  const MyLocationMarker({super.key, required this.point});

  @override
  Widget build(BuildContext context) {
    return MarkerLayer(markers: [
      Marker(
        point: point,
        width: 44,
        height: 44,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue.withValues(alpha: 0.25),
          ),
          child: Center(
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
                border: Border.all(color: Colors.white, width: 3),
                boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 6)],
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}

// Atribución obligatoria de los mapas
class MapAttribution extends StatelessWidget {
  final bool satellite;
  const MapAttribution({super.key, this.satellite = false});

  @override
  Widget build(BuildContext context) {
    return SimpleAttributionWidget(
      source: Text(satellite ? 'Esri' : 'OpenStreetMap'),
    );
  }
}
