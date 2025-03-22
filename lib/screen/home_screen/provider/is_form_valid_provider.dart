part of '../home_screen.dart';

@riverpod
bool _isFormValid(Ref ref) {
  final values = [
    for (final pointType in PointType.values)
      ref.watch(pointProvider(pointType))?.position,
    ref.watch(passengersProvider),
    ref.watch(dateProvider),
    ref.watch(timeProvider),
  ];

  return values.every((e) => e != null);
}
