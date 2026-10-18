import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:miscelaneos/presentation/provider/providers.dart';

class PokemonScreen extends StatelessWidget {
  const PokemonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PokemonView(),
    );
  }
}

// Vista de la pantalla donde se muestran los pokemones
class PokemonView extends ConsumerStatefulWidget {
  const PokemonView({super.key});

  @override
  PokemonViewState createState() => PokemonViewState();
}

class PokemonViewState extends ConsumerState<PokemonView> {
  final scrollController = ScrollController();
  void infinityScroll() {

    final currentPokemons = ref.read(pokemonIdsProvider);

    if (currentPokemons.length > 400) {
      scrollController.removeListener(infinityScroll);
      return;
      
    }

    // Verifica si el usuario está a 200 píxeles del final de la lista.
    if ((scrollController.position.pixels + 200) > (scrollController.position.maxScrollExtent)) { 
    
    // Accede al notifier del pokemonIdsProvider para actualizar el estado.
    ref.read(pokemonIdsProvider.notifier).update((state) => [ 
        
        // Mantiene los elementos existentes en el estado actual.
        ...state,
        // Genera 30 nuevos Pokémon comenzando desde el último número. 
        ...List.generate(30, (index) => state.length + index + 1), 
    ]);
      
    }
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener( infinityScroll );
    
    
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
        SliverAppBar(
          title: const Text('Pokemons'),
          floating: true,
          backgroundColor: Colors.white.withValues(alpha: 0.8),
        ),
        const _PokemonGrid()
      ],
    );
  }
}

// Apartado independiente donde se muestran los demas pokemones 
class _PokemonGrid extends ConsumerWidget {
  const _PokemonGrid();

  @override
  Widget build(BuildContext context, ref) {

    final pokemonIds = ref.watch(pokemonIdsProvider);


    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: pokemonIds.length,
      itemBuilder: (context, index) {
        
        return GestureDetector(
            onTap: () => context.push('/pokemons/${index+1}'),
            child: Image.network(
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index + 1}.png',
              fit: BoxFit.contain,
            ));
      },
    );
  }
}
