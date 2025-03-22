part of '../home_screen.dart';

@riverpod
class _Date extends _$Date {
  @override
  DateTime? build() {
    return null;
  }

  void newDate(DateTime value) {
    if (value == state) {
      return;
    }

    state = value;
  }
}
