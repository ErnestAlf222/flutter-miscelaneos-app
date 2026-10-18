import 'package:go_router/go_router.dart';
import 'package:miscelaneos/presentation/screens/screens.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/permissions',
      builder: (context, state) => const PermissionsScreen(),
    ),

    // Sensors
    GoRoute(
      path: '/gyroscope',
      builder: (context, state) => const GyroscopeScreen(),
    ),
    GoRoute(
      path: '/accelerometer',
      builder: (context, state) => const AccelerometerScreen(),
    ),
    GoRoute(
      path: '/magnetometer',
      builder: (context, state) => const MagnetometerScreen(),
    ),
    GoRoute(
      path: '/gyroscope-ball',
      builder: (context, state) => const GyroscopeBallScreen(),
    ),
    GoRoute(
      path: '/compass',
      builder: (context, state) => const CompassScreen(),
    ),
    GoRoute(
      path: '/pokemons',
      builder: (context, state) => const PokemonScreen(),
      routes: [
        GoRoute(
          // cualquier valor en esa parte de la ruta será capturado como el parámetro id
          path: ':id',
          builder: (context, state) { 
            // idPokemoncito para acceder al ID extraído de la URL
            final idPokemoncito = state.pathParameters['id'] ?? '1';  
            return OnlyPokemonScreen(pokemonId: idPokemoncito);
            },
        ),
      ],
    ),
  ],
);
