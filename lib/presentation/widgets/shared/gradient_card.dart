import 'package:flutter/material.dart';
import 'package:miscelaneos/config/config.dart';

// Contenedor con degradado y sombra suave
class GradientCard extends StatelessWidget {
  final Widget child;
  final Gradient? gradient;
  final EdgeInsetsGeometry padding;
  final double radius;

  const GradientCard({
    super.key,
    required this.child,
    this.gradient,
    this.padding = const EdgeInsets.all(20),
    this.radius = 28,
  });

  @override
  Widget build(BuildContext context) {
    final g = gradient ?? AppTheme.brandGradient;
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        gradient: g,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: g.colors.first.withValues(alpha: 0.30),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}
