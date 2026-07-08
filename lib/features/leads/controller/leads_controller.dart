import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sale_pipeline_business/features/leads/data/leads_repository.dart';

import '../../../network/model/default_network_response.dart';

part 'leads_controller.g.dart';

@riverpod
class UpdateLeadController extends _$UpdateLeadController {
  @override
  FutureOr<void> build() {}

  Future<DefaultNetworkResponse?> updateLead({
    required Map<String, dynamic> payload,
  }) async {
    state = const AsyncValue.loading();

    final repo = ref.read(leadsRepositoryProvider);

    final result = await AsyncValue.guard<DefaultNetworkResponse>(() {
      return repo.updateLead(payload: payload);
    });

    state = result.hasError
        ? AsyncValue.error(result.error!, result.stackTrace!)
        : const AsyncValue.data(null);

    return result.valueOrNull;
  }
}