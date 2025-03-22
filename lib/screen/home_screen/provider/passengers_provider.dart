part of '../home_screen.dart';

@riverpod
class _Passengers extends _$Passengers {
  @override
  int? build() {
    return null;
  }

  void increase() {
    final state = this.state ?? 0;

    if (state == AppConstants.maxPassengersCount) {
      return;
    }

    this.state = state + 1;
  }

  void decrease() {
    final state = this.state ?? 1;

    if (state == 1) {
      return;
    }

    this.state = state - 1;
  }
}
