import 'package:flutter_riverpod/legacy.dart';
import 'package:permission_handler/permission_handler.dart';

// Se crea un provider para poder acceder al estado de los permisos de la aplicación desde cualquier parte de la aplicación
final permissionsProvider = StateNotifierProvider<PermissionsNotifier, PermissionsState>((ref) {
  return PermissionsNotifier();
});


class PermissionsNotifier extends StateNotifier<PermissionsState> {
  PermissionsNotifier() : super(PermissionsState());

  // Se crea un método para poder actualizar el estado de los permisos de la aplicación
  Future<void> checkPermissions() async {
    // Se crea un array de permisos para poder obtener el estado de todos los permisos de la aplicación
    final permissionsArray = await Future.wait([
      Permission.camera.status,
      Permission.photos.status,
      Permission.sensors.status,
      Permission.location.status,
      Permission.locationAlways.status,
      Permission.locationWhenInUse.status
    ]);
    // Se actualiza el estado de los permisos de la aplicación con el estado de los permisos obtenidos
    state = state.copyWith(
      camera: permissionsArray[0],
      photoLibrary: permissionsArray[1],
      sensors: permissionsArray[2],
      location: permissionsArray[3],
      locationAlways: permissionsArray[4],
      locationWhenInUse: permissionsArray[5],
    );

  }
  // Se crea un método para poder abrir la configuración de la aplicación para que el usuario pueda habilitar los permisos manualmente
  openSettingsScreen() async {
    openAppSettings();

  }
  
  // Se crea un método para poder solicitar el permiso de la cámara y actualizar el estado de los permisos de la aplicación con el estado del permiso obtenido
  void _checkPermissionsState(PermissionStatus status){
    if (status.isPermanentlyDenied) {
      openSettingsScreen();
    }
  }

  requestCameraAccess() async {
    // Se solicita el permiso de la cámara y se actualiza el estado de los permisos de la aplicación con el estado del permiso obtenido
    final status = await Permission.camera.request();
    state = state.copyWith(camera: status);

    // Si el permiso es denegado permanentemente, se abre la configuración de la aplicación para que el usuario pueda habilitar el permiso manualmente
    _checkPermissionsState(status);
  }
  // Metodo para abrir fotos library access
  requestPhotoLibraryAccess() async {
    final status = await Permission.photos.request();
    state = state.copyWith(photoLibrary: status);
    _checkPermissionsState(status);
  }
  // Metodo para abrir localización access
  requestLocationAccess() async {
    final status = await Permission.location.request();
    state = state.copyWith(location: status);
    _checkPermissionsState(status);
  }
  // Metodo para abrir sensores del dispositivo access
  requestSensorsAccess() async {
    final status = await Permission.sensors.request();
    state = state.copyWith(sensors: status);
    _checkPermissionsState(status);
  }
}

// Sirve para mantener el estado de los permisos de la aplicación y poder actualizarlo desde cualquier parte de la aplicación
class PermissionsState {
  final PermissionStatus? camera;
  final PermissionStatus? photoLibrary;
  final PermissionStatus? sensors;
  final PermissionStatus? location;
  final PermissionStatus? locationAlways;
  final PermissionStatus? locationWhenInUse;

  PermissionsState({
    this.camera = PermissionStatus.denied,
    this.photoLibrary = PermissionStatus.denied,
    this.sensors = PermissionStatus.denied,
    this.location = PermissionStatus.denied,
    this.locationAlways = PermissionStatus.denied,
    this.locationWhenInUse = PermissionStatus.denied,
  });

  get cameraGranted {
    return camera == PermissionStatus.granted;
  }

  get photoLibraryGranted {
    return photoLibrary == PermissionStatus.granted;
  }

  get sensorsGranted {
    return sensors == PermissionStatus.granted;
  }

  get locationGranted {
    return location == PermissionStatus.granted;
  }

  get locationAlwaysGranted {
    return locationAlways == PermissionStatus.granted;
  }

  get locationWhenInUseGranted {
    return locationWhenInUse == PermissionStatus.granted;
  }

  // Se crea para poder actualizar el estado de los permisos sin tener que crear un nuevo objeto cada vez
  PermissionsState copyWith({
    PermissionStatus? camera,
    PermissionStatus? photoLibrary,
    PermissionStatus? sensors,
    PermissionStatus? location,
    PermissionStatus? locationAlways,
    PermissionStatus? locationWhenInUse,
  }) =>
      PermissionsState(
          camera: camera ?? this.camera,
          photoLibrary: photoLibrary ?? this.photoLibrary,
          sensors: sensors ?? this.sensors,
          location: location ?? this.location,
          locationAlways: locationAlways ?? this.locationAlways,
          locationWhenInUse: locationWhenInUse ?? this.locationWhenInUse);
}
