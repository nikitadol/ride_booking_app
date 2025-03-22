import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class AppConstants {
  const AppConstants._();

  static const String googleMapsApiKey = String.fromEnvironment(
    'GOOGLE_MAPS_API_KEY',
  );

  static const Duration maxFutureDateDif = Duration(days: 180);

  static const int maxPassengersCount = 10;

  // values from https://en.wikipedia.org/wiki/Module:Location_map/data/Alps
  static const alpsCenterPosition = CameraPosition(
    target: LatLng(45.625, 10.75),
    zoom: 6,
  );

  static final alpsCameraUpdate = CameraUpdate.newLatLngBounds(
    LatLngBounds(
      southwest: const LatLng(42.75, 4.5),
      northeast: const LatLng(48.5, 17),
    ),
    16,
  );
}
