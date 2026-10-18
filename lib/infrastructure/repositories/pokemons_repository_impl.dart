

import 'package:miscelaneos/domain/domain.dart';
import 'package:miscelaneos/infrastructure/datasources/pokemons_datasources_impl.dart';

class PokemonsRepositoryImpl implements PokemonsRepository {
  final PokemonsDatasource datasource;
  PokemonsRepositoryImpl(PokemonsDatasource? datasource)
      : datasource = datasource ?? PokemonsDatasourcesImpl();

  @override
  Future<(Pokemon?, String)> getPokemon(String id) async {
    return datasource.getPokemon(id);
  }
}
