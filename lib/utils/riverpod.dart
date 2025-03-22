import 'package:flutter_riverpod/flutter_riverpod.dart';

extension DebounceExtension on Ref {
  Future<void> debounce([
    Duration duration = const Duration(milliseconds: 300),
  ]) async {
    bool wasCancelled = false;
    onDispose(() => wasCancelled = true);

    await Future.delayed(duration);

    if (wasCancelled) {
      throw Exception('Cancelled');
    }
  }
}
