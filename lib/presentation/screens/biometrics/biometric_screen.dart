import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/provider/providers.dart';

class BiometricScreen extends ConsumerWidget {
  const BiometricScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final canCheckBiometrics = ref.watch(canCheckBiometricsProvider);
    final localAuthState = ref.watch(localAuthProvider);
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final isAuthenticating =
        localAuthState.status == LocalAuthStatus.authenticating;
    final isAuthenticated =
        localAuthState.status == LocalAuthStatus.autheticated;

    final (IconData icon, Color background, Color foreground, String title) =
        switch (localAuthState.status) {
      LocalAuthStatus.autheticated => (
          Icons.verified_user_rounded,
          colors.primaryContainer,
          colors.onPrimaryContainer,
          'Autenticado',
        ),
      LocalAuthStatus.authenticating => (
          Icons.fingerprint_rounded,
          colors.secondaryContainer,
          colors.onSecondaryContainer,
          'Verificando…',
        ),
      LocalAuthStatus.notAutheticated => (
          Icons.lock_outline_rounded,
          colors.surfaceContainerHighest,
          colors.onSurfaceVariant,
          'Sin autenticar',
        ),
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Biometría')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic,
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Column(
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          transitionBuilder: (child, animation) =>
                              ScaleTransition(
                            scale: animation,
                            child: FadeTransition(
                                opacity: animation, child: child),
                          ),
                          child: isAuthenticating
                              ? SizedBox(
                                  key: const ValueKey('loading'),
                                  width: 72,
                                  height: 72,
                                  child: CircularProgressIndicator(
                                    color: foreground,
                                    strokeWidth: 5,
                                  ),
                                )
                              : Icon(
                                  icon,
                                  key: ValueKey(localAuthState.status),
                                  size: 72,
                                  color: foreground,
                                ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          title,
                          style: textTheme.headlineSmall
                              ?.copyWith(color: foreground),
                        ),
                        if (localAuthState.message.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            localAuthState.message,
                            textAlign: TextAlign.center,
                            style: textTheme.bodyMedium
                                ?.copyWith(color: foreground),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  canCheckBiometrics.when(
                    data: (canCheck) => _CapabilityTile(
                      icon: canCheck
                          ? Icons.check_circle_rounded
                          : Icons.cancel_rounded,
                      color: canCheck ? colors.primary : colors.error,
                      label: canCheck
                          ? 'Biométricos disponibles'
                          : 'Biométricos no disponibles',
                    ),
                    error: (error, _) => _CapabilityTile(
                      icon: Icons.error_rounded,
                      color: colors.error,
                      label: '$error',
                    ),
                    loading: () => const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: isAuthenticating
                        ? null
                        : () => ref
                            .read(localAuthProvider.notifier)
                            .autheticateUser(),
                    icon: const Icon(Icons.fingerprint_rounded),
                    label: Text(isAuthenticated
                        ? 'Volver a autenticar'
                        : 'Autenticar'),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CapabilityTile extends StatelessWidget {
  const _CapabilityTile({
    required this.icon,
    required this.color,
    required this.label,
  });

  final IconData icon;
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      margin: EdgeInsets.zero,
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(label),
      ),
    );
  }
}
