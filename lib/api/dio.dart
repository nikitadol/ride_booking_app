import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retry/retry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio.g.dart';

const _retryOptions = RetryOptions(maxAttempts: 100);

@riverpod
Dio dio(Ref ref) {
  final dio = Dio();

  dio.interceptors.add(
    RetryInterceptor(
      dio: dio,
      retries: _retryOptions.maxAttempts,
      retryDelays: [
        for (int i = 1; i <= _retryOptions.maxAttempts; i++)
          _retryOptions.delay(i),
      ],
    ),
  );

  ref.onDispose(dio.close);

  return dio;
}
