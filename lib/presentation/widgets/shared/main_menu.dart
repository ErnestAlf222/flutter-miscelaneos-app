import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:miscelaneos/config/config.dart';
import 'package:miscelaneos/presentation/provider/providers.dart';

// Categorías del menú principal con su color distintivo
enum MenuCategory {
  sensors('Sensores', 'Mide el movimiento de tu equipo', Color(0xFF4F46E5)),
  location('Ubicación', 'Dónde estás y cómo llegar', Color(0xFF0E9F6E)),
  security('Seguridad', 'Protege tu acceso', Color(0xFFE11D48)),
  explore('Explorar', 'Diversión y contenido', Color(0xFFF59E0B)),
  tools('Herramientas', 'Avisos y recompensas', Color(0xFF0891B2));

  final String title;
  final String subtitle;
  final Color color;
  const MenuCategory(this.title, this.subtitle, this.color);
}

class MenuItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final String route;
  final MenuCategory category;

  const MenuItem(this.title, this.subtitle, this.icon, this.route, this.category);
}

// Todas las opciones de la app, agrupadas por categoría
const menuItems = <MenuItem>[
  MenuItem('Brújula', 'Tu orientación', Icons.explore_rounded, '/compass', MenuCategory.sensors),
  MenuItem('Nivel', 'Bola con inclinación', Icons.sports_baseball_rounded, '/gyroscope-ball', MenuCategory.sensors),
  MenuItem('Acelerómetro', 'Fuerza de movimiento', Icons.speed_rounded, '/accelerometer', MenuCategory.sensors),
  MenuItem('Giroscopio', 'Velocidad de giro', Icons.downloading_rounded, '/gyroscope', MenuCategory.sensors),
  MenuItem('Magnetómetro', 'Campo magnético', Icons.compass_calibration_rounded, '/magnetometer', MenuCategory.sensors),
  MenuItem('Mi ubicación', 'Coordenadas en vivo', Icons.my_location_rounded, '/location', MenuCategory.location),
  MenuItem('Mapa', 'Explora tu zona', Icons.map_rounded, '/maps', MenuCategory.location),
  MenuItem('Mapa guiado', 'Controles y seguimiento', Icons.gamepad_rounded, '/controlled-map', MenuCategory.location),
  MenuItem('Biometría', 'Huella o rostro', Icons.fingerprint_rounded, '/biometric', MenuCategory.security),
  MenuItem('Permisos', 'Gestiona accesos', Icons.shield_rounded, '/permissions', MenuCategory.security),
  MenuItem('Pokédex', 'Explora y comparte', Icons.catching_pokemon_rounded, '/pokemons', MenuCategory.explore),
  MenuItem('Contador', 'Número en el icono', Icons.notifications_active_rounded, '/badge', MenuCategory.tools),
  MenuItem('Anuncio', 'Pantalla completa', Icons.ad_units_rounded, '/ads', MenuCategory.tools),
  MenuItem('Recompensas', 'Gana monedas', Icons.monetization_on_rounded, '/ads-rewarded', MenuCategory.tools),
];

// Sección del menú: título + cuadrícula de tarjetas
class MenuSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final IconData? icon;
  final List<MenuItem> items;

  const MenuSection({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.items,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 22, 4, 12),
          child: Row(
            children: [
              Container(
                width: 6,
                height: 32,
                decoration: BoxDecoration(
                  gradient: AppTheme.gradientFrom(color),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: text.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                    Text(subtitle,
                        style: text.bodySmall?.copyWith(color: colors.onSurfaceVariant)),
                  ],
                ),
              ),
              if (icon != null) Icon(icon, color: color),
            ],
          ),
        ),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.3,
          children: [for (final e in items) HomeMenuItem(item: e)],
        ),
      ],
    );
  }
}

// Tarjeta con degradado; la estrella la fija en favoritos
class HomeMenuItem extends ConsumerWidget {
  final MenuItem item;

  const HomeMenuItem({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gradient = AppTheme.gradientFrom(item.category.color);
    final isFav = ref.watch(favoritesProvider).contains(item.route);

    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: item.category.color.withValues(alpha: 0.28),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: () => context.push(item.route),
          onLongPress: () => ref.read(favoritesProvider.notifier).toggle(item.route),
          child: Stack(
            children: [
              // Icono grande translúcido de fondo
              Positioned(
                right: -10,
                bottom: -12,
                child: Icon(item.icon,
                    size: 84, color: Colors.white.withValues(alpha: 0.16)),
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.22),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Icon(item.icon, color: Colors.white, size: 22),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15)),
                        Text(item.subtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white70, fontSize: 11)),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 2,
                right: 2,
                child: IconButton(
                  visualDensity: VisualDensity.compact,
                  tooltip: isFav ? 'Quitar de favoritos' : 'Fijar en favoritos',
                  onPressed: () => ref.read(favoritesProvider.notifier).toggle(item.route),
                  icon: Icon(
                    isFav ? Icons.star_rounded : Icons.star_outline_rounded,
                    color: isFav ? Colors.amber : Colors.white70,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
