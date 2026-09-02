import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../utils/secure_storage.dart';
import 'deadline_retry_interceptor.dart';
import 'session_interceptor.dart';

part 'dio_provider.g.dart';

@Riverpod(keepAlive: true)
Dio dio(DioRef ref) {
  final token = ref.watch(
    getAuthTokenProvider,
  );

  final savedBaseUrl = ref.watch(
    getBaseApiUrlProvider,
  );

  if (savedBaseUrl == null ||
      savedBaseUrl.trim().isEmpty) {
    throw StateError(
      'Base API URL is not available. Please login again.',
    );
  }

  /// Remove trailing slash
  final cleanBaseUrl = savedBaseUrl
      .trim()
      .replaceFirst(
    RegExp(r'/+$'),
    '',
  );

  /// Always produce:
  /// https://example.com/api/
  final baseUrl =
      '$cleanBaseUrl/api/';

  debugPrint(
    'Saved URL >>> $savedBaseUrl',
  );

  debugPrint(
    'Base URL >>> $baseUrl',
  );

  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout:
      const Duration(seconds: 12),
      receiveTimeout:
      const Duration(seconds: 20),
      sendTimeout:
      const Duration(seconds: 20),
      responseType:
      ResponseType.json,
      headers: {
        'Content-Type':
        'application/json',
        'Accept':
        'application/json',

        if (token != null &&
            token.isNotEmpty) ...{
          'token': token,
          'Authorization':
          'Bearer $token',
        },
      },
    ),
  );

  /// Request logger / deadline
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (
          options,
          handler,
          ) {
        options.extra.putIfAbsent(
          'deadline',
              () => DateTime.now().add(
            const Duration(
              minutes: 1,
            ),
          ),
        );

        debugPrint(
          'API Request >>> ${options.method} ${options.uri}',
        );

        handler.next(
          options,
        );
      },

      onResponse: (
          response,
          handler,
          ) {
        debugPrint(
          'API Response >>> ${response.statusCode} ${response.requestOptions.uri}',
        );

        handler.next(
          response,
        );
      },

      onError: (
          error,
          handler,
          ) {
        debugPrint(
          'API Error >>> ${error.requestOptions.uri}',
        );

        debugPrint(
          'API Error Type >>> ${error.type}',
        );

        debugPrint(
          'API Status >>> ${error.response?.statusCode}',
        );

        debugPrint(
          'API Data >>> ${error.response?.data}',
        );

        handler.next(
          error,
        );
      },
    ),
  );

  dio.interceptors.add(
    DeadlineRetryInterceptor(
      dio,
    ),
  );

  dio.interceptors.add(
    SessionInterceptor(),
  );

  return dio;
}