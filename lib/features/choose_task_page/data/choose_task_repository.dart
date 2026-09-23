import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../network/api_constants.dart';
import '../../../network/dio_provider.dart';
import '../../../network/error_handler.dart';
import '../../../utils/secure_storage.dart';
import '../model/organizations_response.dart';

part 'choose_task_repository.g.dart';

class ChooseTaskRepository {
  ChooseTaskRepository({
    required this.dio,
  });

  final Dio dio;

  Future<OrganizationsResponse>
  fetchOrganizationList() async {
    try {
      final response = await dio.get(
        kEndPointGetOrganizations,
      );

      return OrganizationsResponse.fromJson(
        response.data,
      );
    } on DioException catch (e) {
      final responseData = e.response?.data;

      if (responseData
      is Map<String, dynamic>) {
        throw responseData['message']
            ?.toString() ??
            ErrorHandler
                .handle(e)
                .failure
                .message;
      }

      throw ErrorHandler
          .handle(e)
          .failure
          .message;
    }
  }
}

/// ============================================================
/// REPOSITORY
/// ============================================================

@riverpod
ChooseTaskRepository chooseTaskRepository(
    ChooseTaskRepositoryRef ref,
    ) {
  return ChooseTaskRepository(
    dio: ref.watch(
      dioProvider,
    ),
  );
}

/// ============================================================
/// ORGANIZATION LIST
/// ============================================================

@riverpod
Future<OrganizationsResponse?> fetchOrganizationList(
    FetchOrganizationListRef ref,
    ) async {
  /// Check session first.
  final token = ref.watch(
    getAuthTokenProvider,
  );

  final baseApiUrl = ref.watch(
    getBaseApiUrlProvider,
  );

  if (token == null ||
      token.trim().isEmpty ||
      baseApiUrl == null ||
      baseApiUrl.trim().isEmpty) {
    debugPrint(
      'Skip organization API >>> '
          'token/base API URL unavailable',
    );

    return null;
  }

  /// Only create repository after session is valid.
  final repository = ref.watch(
    chooseTaskRepositoryProvider,
  );

  return repository.fetchOrganizationList();
}