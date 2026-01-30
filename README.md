# ecommerce_prueba

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

[crea las clases o modelos en flutter](https://app.quicktype.io/)
shared_preferences para guardar en base local
se ejecuta este comando cada que se hacen cambios en el appModule... flutter packages pub run build_runner build

se instala la extension Bloc por Felix Angelov

path: ^1.9.1 ... libreria para trabajar directamente con archivos

image picker .. para seleccionar imagen de galeria o foto

// se agregan estas lineas para darle permisos a la camara y galeria en IOS en esta ruta: <project root>/ios/Runner/Info.plist

<!-- <key>NSPhotoLibraryUsageDescription</key>
	<string>Requiere permisos para acceder a la galeria de fotos</string>
	<key>NSCameraUsageDescription</key>
	<string>Requiere permisos para acceder a la camara</string> -->

el dispose se ejecuta cuando se cierra de pantalla actual

flutter packages pub run build_runner watch .. ejecutar ese comando para crear el archivo de inyeccion
de dependencia
geolocator: ^14.0.2... para obtener ubicacion
