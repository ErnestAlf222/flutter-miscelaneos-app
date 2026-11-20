import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/config/config.dart';
import 'package:miscelaneos/domain/domain.dart';
import 'package:miscelaneos/presentation/provider/providers.dart';
import 'package:miscelaneos/presentation/widgets/widgets.dart';

// Carga un pokemon por id y muestra su detalle
class OnlyPokemonScreen extends ConsumerWidget {
  final String pokemonId;
  const OnlyPokemonScreen({super.key, required this.pokemonId});

  @override
  Widget build(BuildContext context, ref) {
    final pokemonAsync = ref.watch(pokemonProvider(pokemonId));

    return pokemonAsync.when(
      data: (pokemon) => OnlyPokemonView(pokemon: pokemon),
      loading: () => Scaffold(appBar: AppBar(), body: const LoadingView()),
      error: (e, _) => Scaffold(
        appBar: AppBar(),
        body: StateMessage(
          icon: Icons.cloud_off_rounded,
          title: 'No pudimos cargarlo',
          message: 'Revisa tu conexión e inténtalo de nuevo.',
          onAction: () => ref.invalidate(pokemonProvider(pokemonId)),
        ),
      ),
    );
  }
}

class OnlyPokemonView extends StatelessWidget {
  final Pokemon pokemon;
  const OnlyPokemonView({super.key, required this.pokemon});

  // Primera letra en mayúscula
  String get _name => pokemon.name.isEmpty
      ? ''
      : pokemon.name[0].toUpperCase() + pokemon.name.substring(1);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            tooltip: 'Compartir',
            onPressed: () => SharePlugin.shareLink(
              'https://flutter-deep-linking-webapp.vercel.app/pokemons/${pokemon.id}/',
              'Mira este pokemón',
            ),
            icon: const Icon(Icons.share_rounded),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 260,
              height: 260,
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
              padding: const EdgeInsets.all(28),
              child: Hero(
                tag: 'pokemon-${pokemon.id}',
                child: Image.network(pokemon.spriteFront, fit: BoxFit.contain),
              ),
            ),
            const SizedBox(height: 28),
            Text('#${pokemon.id.toString().padLeft(3, '0')}',
                style: text.titleMedium?.copyWith(color: colors.onSurfaceVariant)),
            Text(_name,
                style: text.headlineLarge?.copyWith(fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}
