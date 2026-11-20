import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:miscelaneos/config/config.dart';
import 'package:miscelaneos/presentation/widgets/widgets.dart';

// Bienvenida animada; luego pasa al inicio
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 1100))
        ..forward();

  @override
  void initState() {
    super.initState();
    // Espera un momento y entra a la app
    Future.delayed(const Duration(milliseconds: 2200), () {
      if (mounted) context.go('/');
    });
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fade = CurvedAnimation(parent: _c, curve: Curves.easeOut);
    final scale = Tween<double>(begin: 0.7, end: 1).animate(
        CurvedAnimation(parent: _c, curve: Curves.elasticOut));

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(gradient: AppTheme.brandGradient),
        child: SafeArea(
          child: FadeTransition(
            opacity: fade,
            child: Column(
              children: [
                const Spacer(flex: 3),
                ScaleTransition(
                  scale: scale,
                  child: Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white38, width: 2),
                    ),
                    child: const Icon(Icons.apps_rounded, size: 64, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Miscelaneos',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Tu navaja suiza digital',
                  style: TextStyle(color: Colors.white70, fontSize: 15),
                ),
                const Spacer(flex: 2),
                const AppLoader(size: 44),
                const Spacer(),
                const Text('Hecho por el ingeniero',
                    style: TextStyle(color: Colors.white60, fontSize: 12)),
                const Text(
                  'Ernesto Alfonso Sánchez Montiel',
                  style: TextStyle(
                      color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
