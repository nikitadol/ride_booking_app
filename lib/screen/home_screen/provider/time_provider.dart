part of '../home_screen.dart';

@riverpod
class Time extends _$Time {
  @override
  TimeOfDay? build() {
    return null;
  }

  void newTime(TimeOfDay value) {
    if (value == state) {
      return;
    }

    state = value;
  }
}
