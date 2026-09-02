import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../exceptions/app_exception.dart';
import '../../../network/api_constants.dart';
import '../../../network/dio_no_token.dart';
import '../../../network/error_handler.dart';
import '../../../utils/secure_storage.dart';
import '../model/login_response.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  AuthRepository({required this.dio, required this.ref});

  final Dio dio;
  final Ref ref;

  /// login
  Future<LoginResponseVO> login({
    required String email,
    required String password,
  }) async {
    if (email.trim().isEmpty ||
        password.trim().isEmpty) {
      throw EmptyEmailOrPasswordException();
    }

    try {
      final response = await dio.post(
        kEndPointLogin,
        data: {
          "email": email.trim(),
          "password": password,
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.data == null) {
        throw 'Invalid server response';
      }

      if (response.data is! Map<String, dynamic>) {
        throw 'Invalid server response';
      }

      final loginResponse = LoginResponse.fromJson(
        response.data as Map<String, dynamic>,
      );

      final loginData = loginResponse.data;

      if (loginData == null) {
        throw loginResponse.message ?? 'Login failed';
      }

      final token = loginData.token;

      if (token == null || token.trim().isEmpty) {
        throw loginResponse.message ?? 'Login failed';
      }

      final user = loginData.user;

      if (user == null || user.id == null) {
        throw 'Invalid user information';
      }

      final workspaceUrl =
      loginData.workspaceUrl?.trim();

      if (workspaceUrl == null ||
          workspaceUrl.isEmpty) {
        throw 'Workspace URL not found';
      }

      await ref
          .read(secureStorageProvider)
          .saveAuthToken(token);

      await ref
          .read(secureStorageProvider)
          .saveBaseApiUrl(workspaceUrl);

      ref.invalidate(getAuthTokenProvider);
      ref.invalidate(getBaseApiUrlProvider);

      return loginData;
    } on DioException catch (e) {
      debugPrint(
        'Login Error >>> ${e.response?.data}',
      );

      String message =
          ErrorHandler.handle(e).failure.message;

      final errorData = e.response?.data;

      if (errorData is Map<String, dynamic>) {
        final errors = errorData['errors'];
        if (errors is Map<String, dynamic>) {
          for (final entry in errors.entries) {
            final value = entry.value;

            if (value is List && value.isNotEmpty) {
              message = value.first.toString();
              break;
            }

            if (value != null) {
              message = value.toString();
              break;
            }
          }
        } else {
          message =
              errorData['message']?.toString() ??
                  errorData['error']?.toString() ??
                  message;
        }
      }

      throw message;
    } catch (e) {
      debugPrint(
        'Login Catch Error >>> $e',
      );

      rethrow;
    }
  }
}

@riverpod
AuthRepository authRepositoryNoToken(AuthRepositoryNoTokenRef ref) {
  return AuthRepository(dio: ref.watch(dioNoTokenProvider), ref: ref);
}
