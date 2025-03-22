abstract class AppConstants {
  const AppConstants._();

  static const String googleMapsApiKey = String.fromEnvironment(
    'GOOGLE_MAPS_API_KEY',
  );

  static const Duration maxFutureDateDif = Duration(days: 180);

  static const int maxPassengersCount = 10;
}
