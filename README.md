# Miscelaneos

Aplicación móvil en Flutter que centraliza funcionalidades nativas del dispositivo (cámara, ubicación, sensores, biometría, notificaciones) en una sola interfaz, con acceso a cada recurso a través de plugins y manejo de permisos en Android e iOS.

## Propósito

Ofrecer un punto único para usar y probar capacidades del hardware y del sistema operativo desde Flutter, resolviendo en un solo lugar la integración con plugins, la solicitud de permisos y la navegación entre funciones.

## Arquitectura

- **Capa de presentación:** pantallas y widgets de Flutter, uno por funcionalidad.
- **Gestión de estado:** Riverpod, que mantiene la lógica separada de la UI.
- **Navegación:** go_router, con rutas declarativas por pantalla.
- **Acceso nativo:** cada recurso del dispositivo se encapsula en un servicio propio sobre su plugin, de modo que la UI no depende del plugin directamente.
- **Permisos:** solicitud y verificación centralizadas antes de usar cada recurso.

## Tecnologías

Flutter, Dart, Riverpod, go_router.

## Ejecución

```
flutter pub get
flutter run
```

Para ver cambios al instante, usa `r` (hot reload) en la terminal mientras la app corre.
