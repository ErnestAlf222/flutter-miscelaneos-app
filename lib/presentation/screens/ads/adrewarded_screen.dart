import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:miscelaneos/config/config.dart';
import 'package:miscelaneos/presentation/widgets/widgets.dart';

// Gana monedas viendo un anuncio con recompensa
class AdrewardedScreen extends StatefulWidget {
  const AdrewardedScreen({super.key});

  @override
  State<AdrewardedScreen> createState() => _AdrewardedScreenState();
}

class _AdrewardedScreenState extends State<AdrewardedScreen> {
  RewardedAd? _ad;
  bool _loading = false;
  int _coins = 0;

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

  // Pide un anuncio con recompensa
  void _load() {
    if (!AdsPlugin.supported) return;
    setState(() => _loading = true);
    RewardedAd.load(
      adUnitId: AdsPlugin.rewardedId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
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

  // Muestra el anuncio; suma monedas solo si se completa
  void _show() {
    final ad = _ad;
    if (ad == null) return;
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        if (mounted) setState(() => _ad = null);
        _load();
      },
      onAdFailedToShowFullScreenContent: (ad, _) {
        ad.dispose();
        if (mounted) setState(() => _ad = null);
        _load();
      },
    );
    ad.show(onUserEarnedReward: (_, reward) {
      if (mounted) setState(() => _coins += reward.amount.toInt());
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    if (!AdsPlugin.supported) {
      return Scaffold(
        appBar: AppBar(title: const Text('Recompensas')),
        body: const StateMessage(
          icon: Icons.phone_android_rounded,
          title: 'Solo en móvil',
          message: 'Los anuncios funcionan en Android e iOS.',
        ),
      );
    }

    final ready = _ad != null;
    return Scaffold(
      appBar: AppBar(title: const Text('Recompensas')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(26),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: AppTheme.gradientFrom(Colors.amber.shade600),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.amber.withValues(alpha: 0.4),
                              blurRadius: 28,
                            ),
                          ],
                        ),
                        child: const Icon(Icons.monetization_on_rounded,
                            size: 80, color: Colors.white),
                      ),
                      const SizedBox(height: 12),
                      Text('$_coins',
                          style: text.displayLarge?.copyWith(fontWeight: FontWeight.w700)),
                      Text('monedas',
                          style: text.bodyLarge?.copyWith(color: colors.onSurfaceVariant)),
                    ],
                  ),
                ),
              ),
              FilledButton.icon(
                onPressed: ready ? _show : (_loading ? null : _load),
                icon: Icon(ready ? Icons.play_circle_rounded : Icons.refresh_rounded),
                label: Text(ready
                    ? 'Ver anuncio y ganar'
                    : (_loading ? 'Preparando…' : 'Reintentar')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
