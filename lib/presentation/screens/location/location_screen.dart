import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:miscelaneos/config/config.dart';
import 'package:miscelaneos/presentation/provider/providers.dart';

// Muestra la ubicación puntual y la que se actualiza en vivo
class LocationScreen extends ConsumerWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final current = ref.watch(userLocationProvider);
    final live = ref.watch(watchLocationProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Mi ubicación')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _LocationCard(
            title: 'Ubicación actual',
            icon: Icons.place_rounded,
            value: current,
            onRetry: () => ref.invalidate(userLocationProvider),
          ),
          const SizedBox(height: 16),
          _LocationCard(
            title: 'En tiempo real',
            icon: Icons.podcasts_rounded,
            value: live,
            onRetry: () => ref.invalidate(watchLocationProvider),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () => context.push('/maps'),
            icon: const Icon(Icons.map_rounded),
            label: const Text('Ver en el mapa'),
          ),
        ],
      ),
    );
  }
}

class _LocationCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final AsyncValue<(double, double)> value;
  final VoidCallback onRetry;

  const _LocationCard({
    required this.title,
    required this.icon,
    required this.value,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(icon, color: colors.primary),
            const SizedBox(width: 10),
            Text(title, style: text.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
          ]),
          const SizedBox(height: 16),
          value.when(
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: LinearProgressIndicator(),
            ),
            error: (e, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$e', style: text.bodyMedium?.copyWith(color: colors.error)),
                const SizedBox(height: 8),
                TextButton(onPressed: onRetry, child: const Text('Reintentar')),
              ],
            ),
            data: (d) {
              final (lat, lng) = d;
              final link = 'https://maps.google.com/?q=$lat,$lng';
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Lat  ${lat.toStringAsFixed(6)}', style: text.titleMedium),
                  Text('Lng  ${lng.toStringAsFixed(6)}', style: text.titleMedium),
                  const SizedBox(height: 8),
                  Row(children: [
                    TextButton.icon(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: '$lat, $lng'));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Coordenadas copiadas')),
                        );
                      },
                      icon: const Icon(Icons.copy_rounded, size: 18),
                      label: const Text('Copiar'),
                    ),
                    TextButton.icon(
                      onPressed: () => SharePlugin.shareLink(link, 'Mi ubicación'),
                      icon: const Icon(Icons.share_rounded, size: 18),
                      label: const Text('Compartir'),
                    ),
                  ]),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
