import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// IDs de prueba de Google; cambiar por los reales al publicar
class AdsPlugin {
  // Solo Android/iOS soportan anuncios
  static bool get supported =>
      !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  static String get bannerId => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  static String get interstitialId => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-3940256099942544/4411468910';

  static String get rewardedId => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5224354917'
      : 'ca-app-pub-3940256099942544/1712485313';

  // Inicializa el SDK de anuncios una sola vez
  static Future<void> init() async {
    if (!supported) return;
    await MobileAds.instance.initialize();
  }
}
