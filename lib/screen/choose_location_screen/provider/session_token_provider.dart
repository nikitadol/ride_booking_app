part of '../choose_location_screen.dart';

@riverpod
String _sessionToken(Ref ref) {
  return const Uuid().v4();
}
