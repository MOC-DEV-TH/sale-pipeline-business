import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class DeadlineRetryInterceptor extends Interceptor {
  DeadlineRetryInterceptor(this.dio);

  final Dio dio;

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final data = response.data;

    if (data is Map && data['status_code'] != null) {
      final sc = data['status_code'];
      final int? statusCode = sc is int
          ? sc
          : (sc is String ? int.tryParse(sc) : null);

      if (statusCode != null && statusCode != 200) {
        return handler.reject(
          DioException(
            requestOptions: response.requestOptions,
            response: response,
            type: DioExceptionType.badResponse,
            error: data['message'] ?? 'API error',
          ),
        );
      }
    }

    handler.next(response);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions;

    final isRetryable =
        err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError;

    // Pass through API errors, cancellation, and other errors.
    if (!isRetryable) {
      return handler.next(err);
    }

    // Automatically retry reads only.
    // Retrying POST requests may create duplicate records/payments.
    final method = options.method.toUpperCase();
    if (method != 'GET' && method != 'HEAD') {
      return handler.next(err);
    }

    // Save the deadline so subsequent retries reuse the same value.
    final deadlineRaw = options.extra['deadline'];
    final deadline = deadlineRaw is DateTime
        ? deadlineRaw
        : DateTime.now().add(const Duration(minutes: 1));

    options.extra['deadline'] = deadline;

    if (!DateTime.now().isBefore(deadline)) {
      return handler.next(err);
    }

    try {
      final hasInternet = await InternetConnection().hasInternetAccess;

      if (!hasInternet) {
        return handler.next(
          DioException(
            requestOptions: options,
            type: DioExceptionType.connectionError,
            error: 'No internet connection',
            message: 'No internet connection',
          ),
        );
      }

      await Future<void>.delayed(const Duration(seconds: 3));

      // Check again after waiting.
      if (options.cancelToken?.isCancelled ?? false) {
        return handler.next(options.cancelToken!.cancelError!);
      }

      if (!DateTime.now().isBefore(deadline)) {
        return handler.next(err);
      }

      final response = await dio.fetch<dynamic>(options);
      return handler.resolve(response);
    } on DioException catch (retryError) {
      return handler.next(retryError);
    } catch (error) {
      return handler.next(
        DioException(
          requestOptions: options,
          type: DioExceptionType.unknown,
          error: error,
        ),
      );
    }
  }
}
