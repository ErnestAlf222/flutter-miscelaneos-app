import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const seed = Color(0xFF4F46E5); // Color base de la app

  // Degradado de marca para cabeceras y fondos
  static const brandColors = [Color(0xFF4F46E5), Color(0xFF9333EA), Color(0xFFEC4899)];
  static const brandGradient = LinearGradient(
    colors: brandColors,
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Degradado a partir de un color (tono → tono desplazado)
  static LinearGradient gradientFrom(Color c) {
    final h = HSLColor.fromColor(c);
    final shifted = h.withHue((h.hue + 28) % 360).withLightness((h.lightness * 0.85).clamp(0.0, 1.0));
    return LinearGradient(
      colors: [c, shifted.toColor()],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  ThemeData getTheme() => _build(Brightness.light);
  ThemeData getDarkTheme() => _build(Brightness.dark);

  // Construye el tema según el brillo (claro/oscuro)
  ThemeData _build(Brightness brightness) {
    final scheme = ColorScheme.fromSeed(seedColor: seed, brightness: brightness);
    // Aplica Poppins a cada estilo del tema base
    final b = ThemeData(brightness: brightness, colorScheme: scheme).textTheme;
    TextStyle? f(TextStyle? s) => GoogleFonts.poppins(textStyle: s);
    final text = TextTheme(
      displayLarge: f(b.displayLarge),
      displayMedium: f(b.displayMedium),
      displaySmall: f(b.displaySmall),
      headlineLarge: f(b.headlineLarge),
      headlineMedium: f(b.headlineMedium),
      headlineSmall: f(b.headlineSmall),
      titleLarge: f(b.titleLarge),
      titleMedium: f(b.titleMedium),
      titleSmall: f(b.titleSmall),
      bodyLarge: f(b.bodyLarge),
      bodyMedium: f(b.bodyMedium),
      bodySmall: f(b.bodySmall),
      labelLarge: f(b.labelLarge),
      labelMedium: f(b.labelMedium),
      labelSmall: f(b.labelSmall),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      textTheme: text,
      scaffoldBackgroundColor: scheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        titleTextStyle: text.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: scheme.onSurface,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
    );
  }
}
