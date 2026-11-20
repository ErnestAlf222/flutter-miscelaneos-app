import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:miscelaneos/presentation/provider/providers.dart';
import 'package:miscelaneos/presentation/widgets/widgets.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String _query = ''; // Texto del buscador

  // Saludo según la hora del día
  String get _greeting {
    final h = DateTime.now().hour;
    if (h < 12) return 'Buenos días';
    if (h < 19) return 'Buenas tardes';
    return 'Buenas noches';
  }

  // Rota entre sistema → claro → oscuro
  void _cycleTheme() {
    final mode = ref.read(themeModeProvider);
    final next = switch (mode) {
      ThemeMode.system => ThemeMode.light,
      ThemeMode.light => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.system,
    };
    ref.read(themeModeProvider.notifier).set(next);
    final label = switch (next) {
      ThemeMode.system => 'Tema automático',
      ThemeMode.light => 'Tema claro',
      ThemeMode.dark => 'Tema oscuro',
    };
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(label), duration: const Duration(seconds: 1)));
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final mode = ref.watch(themeModeProvider);
    final favorites = ref.watch(favoritesProvider);
    final q = _query.trim().toLowerCase();

    // Filtra por título o subtítulo
    final filtered = menuItems
        .where((e) =>
            q.isEmpty ||
            e.title.toLowerCase().contains(q) ||
            e.subtitle.toLowerCase().contains(q))
        .toList();
    final favItems = filtered.where((e) => favorites.contains(e.route)).toList();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                    sliver: SliverToBoxAdapter(
                      child: GradientCard(
                        padding: const EdgeInsets.fromLTRB(22, 18, 14, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(_greeting,
                                          style: text.bodyMedium
                                              ?.copyWith(color: Colors.white70)),
                                      Text('Miscelaneos',
                                          style: text.headlineMedium?.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700)),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  tooltip: 'Cambiar tema',
                                  color: Colors.white,
                                  onPressed: _cycleTheme,
                                  icon: Icon(switch (mode) {
                                    ThemeMode.system => Icons.brightness_auto_rounded,
                                    ThemeMode.light => Icons.light_mode_rounded,
                                    ThemeMode.dark => Icons.dark_mode_rounded,
                                  }),
                                ),
                                IconButton(
                                  tooltip: 'Permisos',
                                  color: Colors.white,
                                  onPressed: () => context.push('/permissions'),
                                  icon: const Icon(Icons.shield_outlined),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: SearchBar(
                                hintText: 'Buscar función…',
                                leading: const Icon(Icons.search_rounded),
                                elevation: const WidgetStatePropertyAll(0),
                                onChanged: (v) => setState(() => _query = v),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    sliver: SliverList.list(
                      children: [
                        if (filtered.isEmpty)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 48),
                            child: StateMessage(
                              icon: Icons.search_off_rounded,
                              title: 'Sin resultados',
                              message: 'Prueba con otra palabra.',
                            ),
                          ),
                        // Favoritos fijados por el usuario
                        if (favItems.isNotEmpty)
                          MenuSection(
                            title: 'Favoritos',
                            subtitle: 'Tus accesos rápidos',
                            color: Colors.amber.shade700,
                            icon: Icons.star_rounded,
                            items: favItems,
                          ),
                        for (final c in MenuCategory.values)
                          if (filtered.any((e) => e.category == c))
                            MenuSection(
                              title: c.title,
                              subtitle: c.subtitle,
                              color: c.color,
                              items: filtered.where((e) => e.category == c).toList(),
                            ),
                        if (favItems.isEmpty && q.isEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Text(
                              'Consejo: toca la ★ de una tarjeta para fijarla arriba.',
                              textAlign: TextAlign.center,
                              style: text.bodySmall
                                  ?.copyWith(color: colors.onSurfaceVariant),
                            ),
                          ),
                        const SizedBox(height: 28),
                        const DeveloperCredits(),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const BannerAdView(),
          ],
        ),
      ),
    );
  }
}
