abstract class AppConstants {
  const AppConstants._();

  static const googleMapsApiKey = String.fromEnvironment('GOOGLE_MAPS_API_KEY');

  static const maxFutureDateDif = Duration(days: 180);
}
