import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sale_pipeline_business/network/api_constants.dart';

import '../../../network/dio_provider.dart';
import '../../../network/error_handler.dart';
import '../model/report_summary_response.dart';

part 'home_repository.g.dart';

class HomeRepository {
  HomeRepository({
    required this.dio,
    required this.ref,
  });

  final Dio dio;
  final Ref ref;

  Future<ReportSummaryResponse> fetchReportSummaryByOrganizationID({
    required int organizationID,
  }) async {
    try {
      final response = await dio.get(
        kEndPointGetReportSummaryByOrganizationID,
        queryParameters: {
          kParamOrganizationID : organizationID
        },
      );

      if (response.data == null) {
        throw 'Invalid server response';
      }

      return ReportSummaryResponse.fromJson(response.data);
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
    dio: ref.watch(dioProvider),
    ref: ref,
  );
}

@riverpod
Future<ReportSummaryResponse> fetchReportSummaryByOrganizationID(
    FetchReportSummaryByOrganizationIDRef ref, {
      required int organizationID,
    }) async {
  final repository = ref.watch(homeRepositoryProvider);

  return repository.fetchReportSummaryByOrganizationID(
    organizationID: organizationID,
  );
}