import 'package:app_badge_plus/app_badge_plus.dart';
import 'package:flutter/foundation.dart';

class AppBadgePlugin {
  static Future<bool> get isBadgeSuported {
    return AppBadgePlus.isSupported();
  }

  // Actualiza el número del icono (nunca menor a 0)
  static Future<void> updateBadgeCount(int count) async {
    try {
      if (!await isBadgeSuported) {
        debugPrint('Badge no soportado');
        return;
      }
      await AppBadgePlus.updateBadge(count < 0 ? 0 : count);
    } catch (e) {
      debugPrint('Error en badge: $e');
    }
  }

  static Future<void> removedBadge() => updateBadgeCount(0);
}
