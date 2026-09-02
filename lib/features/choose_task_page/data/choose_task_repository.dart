import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sale_pipeline_business/features/choose_task_page/model/organizations_response.dart';
import '../../../network/api_constants.dart';
import '../../../network/dio_provider.dart';
import '../../../network/error_handler.dart';
part 'choose_task_repository.g.dart';

class ChooseTaskRepository {
  ChooseTaskRepository({
    required this.dio,
    required this.ref,
  });

  final Dio dio;
  final Ref ref;

  Future<OrganizationsResponse> fetchOrganizationList() async {
    try {
      final response = await dio.get(kEndPointGetOrganizations);

      return OrganizationsResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw e.response?.data["message"] ??
          ErrorHandler
              .handle(e)
              .failure
              .message;
    }
  }

}

@riverpod
ChooseTaskRepository chooseTaskRepository(ChooseTaskRepositoryRef ref) {
  return ChooseTaskRepository(
    dio: ref.watch(dioProvider),
    ref: ref,
  );
}


@riverpod
Future<OrganizationsResponse> fetchOrganizationList(
    FetchOrganizationListRef ref) async {
  final repository = ref.watch(chooseTaskRepositoryProvider);

  return repository.fetchOrganizationList();
}
