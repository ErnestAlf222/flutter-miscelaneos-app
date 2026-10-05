import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/config/config.dart';
import 'package:miscelaneos/presentation/provider/providers.dart';

void main() {
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

    print('AppLifecycleState: $state');
    ref.read(appStateProvider.notifier).state = state;
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(
      routerConfig: router,
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
