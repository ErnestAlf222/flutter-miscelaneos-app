import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

final watchLocationProvider =
    StreamProvider.autoDispose<(double lat, double lng)>((ref) async* {

  /// Verifica que el servicio de ubicación esté activo y que los permisos
  /// estén concedidos. Si no es así, lanza un error.
  Future<void> checkLocationPermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location services are disabled.';
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permissions are denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Location permissions are permanently denied, we cannot request permissions.';
    }
  }

  await checkLocationPermission();

  await for (final location in Geolocator.getPositionStream()) {
    yield (location.latitude, location.longitude);
  }
});
