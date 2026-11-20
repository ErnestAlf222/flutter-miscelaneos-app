import 'package:flutter/material.dart';

// Créditos del desarrollador al final del inicio
class DeveloperCredits extends StatelessWidget {
  const DeveloperCredits({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: colors.primaryContainer,
            child: Icon(Icons.engineering_rounded, color: colors.onPrimaryContainer),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hecho por el ingeniero',
                    style: text.bodySmall?.copyWith(color: colors.onSurfaceVariant)),
                const SizedBox(height: 2),
                Text('Ernesto Alfonso Sánchez Montiel',
                    style: text.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
