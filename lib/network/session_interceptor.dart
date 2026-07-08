import 'package:dio/dio.dart';

import '../common_widgets/session_expired_dialog.dart' as app_utils;
import '../main.dart';

class SessionInterceptor extends Interceptor {
  static bool isSessionExpiredHandled = false;

  static bool get isSessionExpired => isSessionExpiredHandled;

  static void resetSessionExpired() {
    isSessionExpiredHandled = false;
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _checkSessionExpired(response);
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final response = err.response;

    if (response != null) {
      _checkSessionExpired(response);
    }

    handler.next(err);
  }

  void _checkSessionExpired(Response response) {
    final data = response.data;

    final isExpiredByResponseCode =
        data is Map && data['response_code']?.toString() == '005';

    final isExpiredByHttpStatus =
        response.statusCode == 401 || response.statusCode == 403;

    if ((isExpiredByResponseCode || isExpiredByHttpStatus) &&
        !isSessionExpiredHandled) {
      isSessionExpiredHandled = true;
      _handleSessionExpired();
    }
  }

  void _handleSessionExpired() {
    final context = navigatorKey.currentContext;

    if (context == null) return;

    app_utils.AppUtils.showSessionExpireDialog(
      context: context,
    );
  }
}