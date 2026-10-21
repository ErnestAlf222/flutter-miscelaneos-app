import 'package:local_auth/local_auth.dart';

class LocalAuthPlugin {

  static final LocalAuthentication auth = LocalAuthentication();

  static availableBiometrics() async {
    final List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();

    if (availableBiometrics.isNotEmpty) {
      // Some biometrics are enrolled.
    }

    if (availableBiometrics.contains(BiometricType.strong) ||
        availableBiometrics.contains(BiometricType.face)) {
      // Specific types of biometrics are available.
      // Use checks like this with caution!
    }
  }

  static Future<bool> canChangeBiometrics() async{
    return await auth.canCheckBiometrics;
  }

  static Future<(bool, String)> authenticate({bool biometricOnly = false }) async{
    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Por favor autenticate para continuar',
        biometricOnly: biometricOnly,
      );

      return (didAuthenticate, didAuthenticate ? 'Hecho' : 'Cancelado por el usuario');


    } on LocalAuthException catch (e) {
      print('e');
      if (e.code == LocalAuthExceptionCode.noBiometricsEnrolled) return (false, 'No hay biometricos enrolados');
      if (e.code == LocalAuthExceptionCode.biometricLockout) return (false, 'Muchos intentos fallidos');
      if (e.code == LocalAuthExceptionCode.noBiometricHardware) return (false, 'No hay biometricos disponibles');
      if (e.code == LocalAuthExceptionCode.noCredentialsSet) return (false, 'No hay un PIN en línea');
      if (e.code == LocalAuthExceptionCode.temporaryLockout) return (false, 'Se requiere desbloquear el teléfono nuevamente');

      return (false, e.toString());
    } catch (e) {
      return (false, e.toString());
    }
  }
}