part of '../home_screen.dart';

@riverpod
class TempPoint extends _$TempPoint {
  @override
  LatLng? build() {
    return null;
  }

  void changePosition(LatLng position) {
    if (state == position) {
      return;
    }

    state = position;
  }
}
