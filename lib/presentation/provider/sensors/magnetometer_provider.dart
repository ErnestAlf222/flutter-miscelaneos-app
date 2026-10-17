import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';

class MagnetometerXYZ {
  final double x;
  final double y;
  final double z;

  MagnetometerXYZ({required this.x, required this.y, required this.z});

  // Convierte los valores del giroscopio a un formato más legible (YXZ)
  @override
  String toString() {
    return '''
        GyroscopeYXZ(
              x: $x,
              y: $y,
              z: $z,
            )''';
  }
}


final magnetomerProvider = StreamProvider<MagnetometerXYZ>((ref) async* {

  await for (final event in magnetometerEventStream()) {
    // Convierte los valores del giroscopio a un formato más legible (YXZ)
    final magnetomerXYZ = MagnetometerXYZ(
      x: double.parse(event.y.toStringAsFixed(2)),
      y: double.parse(event.x.toStringAsFixed(2)),
      z: double.parse(event.z.toStringAsFixed(2)),
    );
    yield magnetomerXYZ;
  }

});