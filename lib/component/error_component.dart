import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ErrorComponent extends StatelessWidget {
  const ErrorComponent({
    super.key,
    required this.error,
    required this.stackTrace,
    this.onRetry,
  });

  final Object error;
  final StackTrace stackTrace;

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Something went wrong...'),
            if (onRetry != null) ...[
              const Gap(16),
              FilledButton(onPressed: onRetry, child: const Text('Retry')),
            ],
            if (kDebugMode) ...[Text('$error'), Text('$stackTrace')],
          ],
        ),
      ),
    );
  }
}
