import 'package:flutter/material.dart';


class OnlyPokemonScreen extends StatelessWidget {

  final String pokemonId;
  const OnlyPokemonScreen({super.key, required this.pokemonId, });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon <name>'),
      ),
      body: Center(
        child: Text('PokemonId: $pokemonId'),
      ),
    );
  }
}