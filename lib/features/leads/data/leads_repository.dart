import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sale_pipeline_business/features/leads/model/lead_detail_response.dart';
import 'package:sale_pipeline_business/features/leads/model/leads_response.dart';

import '../../../network/api_constants.dart';
import '../../../network/dio_provider.dart';
import '../../../network/error_handler.dart';
import '../../../network/model/default_network_response.dart';
part 'leads_repository.g.dart';

class LeadsRepository {
  LeadsRepository({
    required this.dio,
    required this.ref,
  });

  final Dio dio;
  final Ref ref;

  Future<LeadsResponse> fetchLeadList({
    required String uid,
    String? filterParamName,
  }) async {
    try {
      final response = await dio.get(
        '$kEndPointLeadListByUid$filterParamName',
        queryParameters: {
          'uid': uid,
          'app_version': '1.0',
        },
      );

      return LeadsResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw e.response?.data["message"] ??
          ErrorHandler
              .handle(e)
              .failure
              .message;
    }
  }

  Future<LeadDetailResponse> fetchLeadDetailByLeadId({
    required String uid,
    required String leadId,
  }) async {
    try {
      final response = await dio.get(
        kEndPointLeadDetailByLeadId,
        queryParameters: {
          'uid': uid,
          'leadId': leadId,
          'app_version': '1.0',
        },
      );

      return LeadDetailResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw e.response?.data["message"] ??
          ErrorHandler
              .handle(e)
              .failure
              .message;
    }
  }


  Future<DefaultNetworkResponse> updateLead({
    required Map<String, dynamic> payload,
  }) async {
    try {
      final response = await dio.post(
        kEndPointUpdateLead,
        data: payload,
      );

      return DefaultNetworkResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw e.response?.data["message"] ??
          ErrorHandler.handle(e).failure.message;
    }
  }

}

@riverpod
LeadsRepository leadsRepository(LeadsRepositoryRef ref) {
  return LeadsRepository(
    dio: ref.watch(dioProvider()),
    ref: ref,
  );
}


@riverpod
Future<LeadsResponse> fetchLeadList(
    FetchLeadListRef ref, {
      required String uid,
      String? filterParamName,
    }) async {
  final repository = ref.watch(leadsRepositoryProvider);

  return repository.fetchLeadList(
    uid: uid,
    filterParamName: filterParamName,
  );
}

@riverpod
Future<LeadDetailResponse> fetchLeadDetail(
    FetchLeadDetailRef ref, {
      required String uid,
      required String leadId,
    }) async {
  final repository = ref.watch(leadsRepositoryProvider);

  return repository.fetchLeadDetailByLeadId(
    uid: uid,
    leadId: leadId,
  );
}