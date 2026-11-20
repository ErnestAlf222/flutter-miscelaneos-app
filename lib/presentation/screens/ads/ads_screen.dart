import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:miscelaneos/config/config.dart';
import 'package:miscelaneos/presentation/widgets/widgets.dart';

// Carga y muestra un anuncio intersticial (pantalla completa)
class AdFullScreen extends StatefulWidget {
  const AdFullScreen({super.key});

  @override
  State<AdFullScreen> createState() => _AdFullScreenState();
}

class _AdFullScreenState extends State<AdFullScreen> {
  InterstitialAd? _ad;
  bool _loading = false;
  int _shown = 0; // Anuncios vistos en esta sesión

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }

  // Pide un anuncio nuevo al SDK
  void _load() {
    if (!AdsPlugin.supported) return;
    setState(() => _loading = true);
    InterstitialAd.load(
      adUnitId: AdsPlugin.interstitialId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() {
            _ad = ad;
            _loading = false;
          });
        },
        onAdFailedToLoad: (_) {
          if (mounted) setState(() => _loading = false);
        },
      ),
    );
  }

  // Muestra el anuncio y prepara el siguiente al cerrarse
  void _show() {
    final ad = _ad;
    if (ad == null) return;
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        if (!mounted) return;
        setState(() {
          _ad = null;
          _shown++;
        });
        _load();
      },
      onAdFailedToShowFullScreenContent: (ad, _) {
        ad.dispose();
        if (mounted) setState(() => _ad = null);
        _load();
      },
    );
    ad.show();
  }

  @override
  Widget build(BuildContext context) {
    if (!AdsPlugin.supported) {
      return Scaffold(
        appBar: AppBar(title: const Text('Anuncio')),
        body: const StateMessage(
          icon: Icons.phone_android_rounded,
          title: 'Solo en móvil',
          message: 'Los anuncios funcionan en Android e iOS.',
        ),
      );
    }

    final ready = _ad != null;
    return Scaffold(
      appBar: AppBar(title: const Text('Anuncio')),
      body: StateMessage(
        icon: ready ? Icons.ad_units_rounded : Icons.hourglass_top_rounded,
        title: ready ? 'Anuncio listo' : (_loading ? 'Preparando anuncio…' : 'Anuncio no disponible'),
        message: _shown > 0
            ? 'Anuncios vistos: $_shown'
            : 'Toca el botón para verlo en pantalla completa.',
        actionLabel: ready ? 'Ver anuncio' : (_loading ? null : 'Reintentar'),
        onAction: _loading ? null : (ready ? _show : _load),
      ),
    );
  }
}
