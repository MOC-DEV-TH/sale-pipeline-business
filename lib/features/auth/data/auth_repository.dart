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
          "user_id": email,
          "password": password,
          "app_version": "1.0",
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "security_key": 'moJoENEt2021sECuriTYkEy',
          },
        ),
      );

      /// null response check
      if (response.data == null) {
        throw 'Invalid server response';
      }

      final data = response.data;

      /// safe token parse
      // final token =
      // data["data"]?["token"];
      // final uid =
      // data["data"]?["uid"];
      final token =
      data["token"];
      final uid =
      data["uid"];

      if (token == null ||
          token.toString().isEmpty) {
        throw data["message"] ??
            'Login failed';
      }

      /// save token
      await ref.read(secureStorageProvider).saveAuthToken(token);

      ///save uid
      await ref.read(secureStorageProvider).saveUid(uid);


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
