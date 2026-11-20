import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:miscelaneos/presentation/provider/providers.dart';
import 'package:miscelaneos/presentation/widgets/widgets.dart';

class PokemonScreen extends StatelessWidget {
  const PokemonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: PokemonView());
  }
}

// Lista con carga infinita de pokemones
class PokemonView extends ConsumerStatefulWidget {
  const PokemonView({super.key});

  @override
  PokemonViewState createState() => PokemonViewState();
}

class PokemonViewState extends ConsumerState<PokemonView> {
  final scrollController = ScrollController();

  // Agrega 30 más cuando faltan 200px para el final (máx. 400)
  void infinityScroll() {
    final current = ref.read(pokemonIdsProvider);

    if (current.length > 400) {
      scrollController.removeListener(infinityScroll);
      return;
    }

    if ((scrollController.position.pixels + 200) >
        scrollController.position.maxScrollExtent) {
      ref.read(pokemonIdsProvider.notifier).update((state) => [
            ...state,
            ...List.generate(30, (index) => state.length + index + 1),
          ]);
    }
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(infinityScroll);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        const SliverAppBar(title: Text('Pokédex'), floating: true),
        // Buscador: abre el detalle por nombre o número
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          sliver: SliverToBoxAdapter(
            child: SearchBar(
              hintText: 'Nombre o número (ej. pikachu, 25)',
              leading: const Icon(Icons.search_rounded),
              elevation: const WidgetStatePropertyAll(0),
              onSubmitted: (v) {
                final q = v.trim().toLowerCase();
                if (q.isNotEmpty) context.push('/pokemons/$q');
              },
            ),
          ),
        ),
        const SliverPadding(
          padding: EdgeInsets.fromLTRB(16, 4, 16, 24),
          sliver: _PokemonGrid(),
        ),
      ],
    );
  }
}

class _PokemonGrid extends ConsumerWidget {
  const _PokemonGrid();

  @override
  Widget build(BuildContext context, ref) {
    final ids = ref.watch(pokemonIdsProvider);
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: ids.length,
      itemBuilder: (context, index) {
        final id = index + 1;
        return Material(
          color: colors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(18),
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () => context.push('/pokemons/$id'),
            child: Stack(
              children: [
                Positioned(
                  top: 8,
                  left: 10,
                  child: Text('#$id',
                      style: text.labelSmall?.copyWith(color: colors.onSurfaceVariant)),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Hero(
                    tag: 'pokemon-$id',
                    child: Image.network(
                      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png',
                      fit: BoxFit.contain,
                      // Mientras carga o si falla, muestra un icono
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.catching_pokemon_rounded),
                      loadingBuilder: (_, child, progress) => progress == null
                          ? child
                          : const Center(child: AppLoader(size: 24)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
