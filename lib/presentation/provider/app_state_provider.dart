
import 'package:flutter/material.dart' show AppLifecycleState;
import 'package:flutter_riverpod/legacy.dart';

final appStateProvider = StateProvider<AppLifecycleState>((ref) {
  // El estado inicial de la aplicación se establece como "resumed" (reanudado) cuando se inicia la aplicación.
  return AppLifecycleState.resumed;
  
});