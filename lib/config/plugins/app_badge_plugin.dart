import 'package:app_badge_plus/app_badge_plus.dart';

class AppBadgePlugin {

  static Future<bool> get isBadgeSuported {
    return AppBadgePlus.isSupported();
  }

  static Future<void> updateBadgeCount(int count) async {
    try {
      if (!await isBadgeSuported) {
        print('Badge no soportado');
        return;
      }
      await AppBadgePlus.updateBadge(count < 0 ? 0 : count);
    } catch (e) {
      print('Error en badge: $e');
    }
  }

  static Future<void> removedBadge() => updateBadgeCount(0);
}
