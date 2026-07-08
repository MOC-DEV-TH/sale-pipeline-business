import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sale_pipeline_business/features/contracts/data/contracts_repository.dart';
import '../../../network/model/default_network_response.dart';

part 'contracts_controller.g.dart';

@riverpod
class ContractsController extends _$ContractsController {
  @override
  FutureOr<void> build() {}

  Future<DefaultNetworkResponse?> updateContractedLead({
    required Map<String, dynamic> payload,
  }) async {
    state = const AsyncValue.loading();

    final repo = ref.read(contractsRepositoryProvider);

    final result = await AsyncValue.guard<DefaultNetworkResponse>(() {
      return repo.updateContractedLead(payload: payload);
    });

    state = result.hasError
        ? AsyncValue.error(result.error!, result.stackTrace!)
        : const AsyncValue.data(null);

    return result.valueOrNull;
  }
}