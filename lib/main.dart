import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:miscelaneos/config/config.dart';
import 'package:miscelaneos/presentation/provider/providers.dart';

Future<void> main() async {
  // Inicializa Flutter antes de arrancar la app
  WidgetsFlutterBinding.ensureInitialized();
  QuickActionsPlugin.registerActions();
  await AdsPlugin.init(); // SDK de anuncios

  // Establece la orientación preferida de la aplicación a modo vertical (portrait)
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(

    // ProviderScope es un widget que proporciona un contenedor para los proveedores de Riverpod. Permite que los widgets hijos accedan a los proveedores y sus estados.
    const ProviderScope(
      child: MainApp()
    )

  );
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends ConsumerState<MainApp> with WidgetsBindingObserver {

  // Oberver para detectar cambios en el estado de la aplicación (por ejemplo, cuando se minimiza o se cierra)
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Lee el estado real de permisos al abrir la app
    Future.microtask(() => ref.read(permissionsProvider.notifier).checkPermissions());
  }

  // Detecta cambios en el estado de la aplicación y realiza acciones según el estado actual
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // Detecta cambios en el estado de la aplicación y realiza acciones según el estado actual
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

    ref.read(appStateProvider.notifier).state = state;
    if(state == AppLifecycleState.resumed){
      // Cuando la aplicación vuelve a primer plano, se verifica el estado de los permisos de la aplicación
      ref.read(permissionsProvider.notifier).checkPermissions();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Miscelaneos',
      routerConfig: router,
      theme: AppTheme().getTheme(),
      darkTheme: AppTheme().getDarkTheme(),
      themeMode: ref.watch(themeModeProvider), // Tema elegido o del sistema
      debugShowCheckedModeBanner: false,
    );
  }
}
