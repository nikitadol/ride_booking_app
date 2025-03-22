part of '../home_screen.dart';

@riverpod
bool _isFormValid(Ref ref) {
  final values = [
    for (final pointType in PointType.values)
      ref.watch(_pointProvider(pointType)),
    ref.watch(_passengersProvider),
    ref.watch(_dateProvider),
    ref.watch(_timeProvider),
  ];

  return values.every((e) => e != null);
}
