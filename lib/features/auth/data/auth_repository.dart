import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../exceptions/app_exception.dart';
import '../../../network/api_constants.dart';
import '../../../network/dio_no_token.dart';
import '../../../network/error_handler.dart';
import '../../../utils/secure_storage.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  AuthRepository({required this.dio, required this.ref});

  final Dio dio;
  final Ref ref;

  /// login
  Future<void> login({
    required String userId,
    required String password,
  }) async {
    if (userId.trim().isEmpty ||
        password.trim().isEmpty) {
      throw EmptyUserIdOrPasswordException();
    }

    try {
      final response = await dio.post(
        kEndPointLogin,
        data: {
          "user_id": userId,
          "password": password,
        },
      );

      /// null response check
      if (response.data == null) {
        throw 'Invalid server response';
      }

      final data = response.data;

      /// safe token parse
      final token =
      data["data"]?["access_token"];

      if (token == null ||
          token.toString().isEmpty) {
        throw data["message"] ??
            'Login failed';
      }

      /// save token
      await GetStorage().write(
        SecureDataList.authToken.name,
        token,
      );

    } on DioException catch (e) {
      debugPrint(
        "Login Error >>> ${e.response?.data}",
      );

      String message =
          ErrorHandler.handle(e)
              .failure
              .message;

      /// safe error parse
      if (e.response?.data != null &&
          e.response?.data
          is Map<String, dynamic>) {
        message =
            e.response?.data["message"] ??
                e.response?.data["error"] ??
                message;
      }

      throw message;
    } catch (e) {
      debugPrint(
        "Login Catch Error >>> $e",
      );

      throw e.toString();
    }
  }
}

@riverpod
AuthRepository authRepositoryNoToken(AuthRepositoryNoTokenRef ref) {
  return AuthRepository(dio: ref.watch(dioNoTokenProvider), ref: ref);
}
