import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sale_pipeline_business/features/contracts/model/contracted_detail_response.dart';
import 'package:sale_pipeline_business/features/contracts/model/contracts_response.dart';

import '../../../network/api_constants.dart';
import '../../../network/dio_provider.dart';
import '../../../network/error_handler.dart';
import '../../../network/model/default_network_response.dart';
part 'contracts_repository.g.dart';

class ContractsRepository {
  ContractsRepository({
    required this.dio,
    required this.ref,
  });

  final Dio dio;
  final Ref ref;

  Future<ContractsResponse> fetchContractsList({
    required String uid,
    String? filterParamName,
  }) async {
    try {
      final response = await dio.get(
        '$kEndPointContractedLeadListByUid$filterParamName',
        queryParameters: {
          'uid': uid,
          'app_version': '1.0',
        },
      );

      return ContractsResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw e.response?.data["message"] ??
          ErrorHandler
              .handle(e)
              .failure
              .message;
    }
  }

  Future<ContractedDetailResponse> fetchContractedLeadDetailByProfileId({
    required String uid,
    required String profileId,
  }) async {
    try {
      final response = await dio.get(
        kEndPointContractedLeadByProfileId,
        queryParameters: {
          'uid': uid,
          'leadId': profileId,
          'app_version': '1.0',
        },
      );

      return ContractedDetailResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw e.response?.data["message"] ??
          ErrorHandler
              .handle(e)
              .failure
              .message;
    }
  }

  Future<DefaultNetworkResponse> updateContractedLead({
    required Map<String, dynamic> payload,
  }) async {
    try {
      final response = await dio.post(
        kEndPointUpdateContractedLead,
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
ContractsRepository contractsRepository(ContractsRepositoryRef ref) {
  return ContractsRepository(
    dio: ref.watch(dioProvider),
    ref: ref,
  );
}


@riverpod
Future<ContractsResponse> fetchContractList(
    FetchContractListRef ref, {
      required String uid,
      String? filterParamName,
    }) async {
  final repository = ref.watch(contractsRepositoryProvider);

  return repository.fetchContractsList(
    uid: uid,
    filterParamName: filterParamName,
  );
}

@riverpod
Future<ContractedDetailResponse> fetchContractedLeadDetail(
    FetchContractedLeadDetailRef ref, {
      required String uid,
      required String profileId,
    }) async {
  final repository = ref.watch(contractsRepositoryProvider);

  return repository.fetchContractedLeadDetailByProfileId(
    uid: uid,
    profileId: profileId,
  );
}