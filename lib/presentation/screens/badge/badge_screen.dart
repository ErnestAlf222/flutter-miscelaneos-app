import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/config/config.dart';
import 'package:miscelaneos/presentation/provider/providers.dart';

// Controla el número que aparece sobre el icono de la app
class BadgeScreen extends ConsumerWidget {
  const BadgeScreen({super.key});

  // Cambia el contador y lo refleja en el icono
  void _change(WidgetRef ref, int delta) {
    final next = (ref.read(badgeCounterProvider) + delta).clamp(0, 999);
    ref.read(badgeCounterProvider.notifier).state = next;
    AppBadgePlugin.updateBadgeCount(next);
  }

  @override
  Widget build(BuildContext context, ref) {
    final count = ref.watch(badgeCounterProvider);
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Contador del icono')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppTheme.brandGradient,
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.brandColors[1].withValues(alpha: 0.4),
                          blurRadius: 30,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Center(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        transitionBuilder: (c, a) => ScaleTransition(scale: a, child: c),
                        child: Text(
                          '$count',
                          key: ValueKey(count),
                          style: text.displayLarge?.copyWith(
                            fontSize: 84,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                'Este número se muestra sobre el icono de la app.',
                textAlign: TextAlign.center,
                style: text.bodyMedium?.copyWith(color: colors.onSurfaceVariant),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.tonal(
                      onPressed: count > 0 ? () => _change(ref, -1) : null,
                      child: const Icon(Icons.remove_rounded),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: () => _change(ref, 1),
                      child: const Icon(Icons.add_rounded),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextButton.icon(
                onPressed: count > 0 ? () => _change(ref, -count) : null,
                icon: const Icon(Icons.delete_outline_rounded),
                label: const Text('Borrar contador'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
