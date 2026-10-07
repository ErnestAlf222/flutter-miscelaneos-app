import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';

class GyroscopeYXZ {
  final double x;
  final double y;
  final double z;

  GyroscopeYXZ({required this.x, required this.y, required this.z});

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


final gyroscopeProvider = StreamProvider<GyroscopeYXZ>((ref) async* {

  await for (final event in gyroscopeEventStream()) {
    // Convierte los valores del giroscopio a un formato más legible (YXZ)
    final gyroscopeYXZ = GyroscopeYXZ(
      x: double.parse(event.y.toStringAsFixed(2)),
      y: double.parse(event.x.toStringAsFixed(2)),
      z: double.parse(event.z.toStringAsFixed(2)),
    );
    yield gyroscopeYXZ;
  }

});