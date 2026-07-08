import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sale_pipeline_business/network/api_constants.dart';

import '../../../network/dio_provider.dart';
import '../../../network/error_handler.dart';
import '../model/activity_overview_response.dart';

part 'home_repository.g.dart';

class HomeRepository {
  HomeRepository({
    required this.dio,
    required this.ref,
  });

  final Dio dio;
  final Ref ref;

  Future<ActivityOverviewResponse> fetchActivityOverview({
    required String uid,
  }) async {
    try {
      final response = await dio.get(
        kEndPointGetActivityOverview,
        queryParameters: {
          'uid': uid,
          'app_version': '1.0',
        },
      );

      if (response.data == null) {
        throw 'Invalid server response';
      }

      return ActivityOverviewResponse.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('Activity Overview Error >>> ${e.response?.data}');

      String message = ErrorHandler.handle(e).failure.message;

      if (e.response?.data is Map<String, dynamic>) {
        message =
            e.response?.data['message'] ??
                e.response?.data['description'] ??
                e.response?.data['error'] ??
                message;
      }

      throw message;
    } catch (e) {
      debugPrint('Activity Overview Catch >>> $e');
      throw e.toString();
    }
  }
}

@riverpod
HomeRepository homeRepository(HomeRepositoryRef ref) {
  return HomeRepository(
    dio: ref.watch(dioProvider()),
    ref: ref,
  );
}

@riverpod
Future<ActivityOverviewResponse> fetchActivityOverview(
    FetchActivityOverviewRef ref, {
      required String uid,
    }) async {
  final repository = ref.watch(homeRepositoryProvider);

  return repository.fetchActivityOverview(
    uid: uid,
  );
}