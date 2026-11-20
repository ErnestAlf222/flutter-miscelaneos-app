import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Tema elegido por el usuario (se guarda en el teléfono)
class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.system) {
    _load();
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getString('theme_mode');
      state = ThemeMode.values.firstWhere(
        (m) => m.name == saved,
        orElse: () => ThemeMode.system,
      );
    } catch (_) {}
  }

  // Cambia el tema y lo guarda
  Future<void> set(ThemeMode mode) async {
    state = mode;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('theme_mode', mode.name);
    } catch (_) {}
  }
}

final themeModeProvider =
    StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) => ThemeModeNotifier());

// Rutas favoritas que se fijan arriba en el inicio
class FavoritesNotifier extends StateNotifier<Set<String>> {
  FavoritesNotifier() : super({}) {
    _load();
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      state = (prefs.getStringList('favorites') ?? []).toSet();
    } catch (_) {}
  }

  // Agrega o quita una ruta de favoritos
  Future<void> toggle(String route) async {
    final next = {...state};
    next.contains(route) ? next.remove(route) : next.add(route);
    state = next;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('favorites', next.toList());
    } catch (_) {}
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, Set<String>>((ref) => FavoritesNotifier());
