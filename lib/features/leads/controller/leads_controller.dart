import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sale_pipeline_business/features/leads/data/leads_repository.dart';

import '../../../network/model/default_network_response.dart';

part 'leads_controller.g.dart';

@riverpod
class LeadsController extends _$LeadsController {
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

  Future<bool> deleteLead({required int leadId}) async {
    state = const AsyncLoading();

    try {
      final repository = ref.read(leadsRepositoryProvider);

      final response = await repository.deleteLead(leadId: leadId);

      state = const AsyncData(null);

      return true;
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);

      return false;
    }
  }

  Future<bool> createActivity({
    required int leadId,
    required Map<String, dynamic> payload,
  }) async {
    state = const AsyncLoading();

    try {
      await ref
          .read(leadsRepositoryProvider)
          .createActivity(leadId: leadId, payload: payload);

      state = const AsyncData(null);

      return true;
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);

      return false;
    }
  }

  Future<bool> createReminder({
    required int leadId,
    required Map<String, dynamic> payload,
  }) async {
    state = const AsyncLoading();

    try {
      await ref
          .read(leadsRepositoryProvider)
          .createReminder(leadId: leadId, payload: payload);

      state = const AsyncData(null);

      return true;
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);

      return false;
    }
  }

  Future<bool> removeActivity({
    required int leadId,
    required int activityLogId,
  }) async {
    state = const AsyncLoading();

    try {
      await ref
          .read(leadsRepositoryProvider)
          .removeActivity(leadId: leadId, activityLogId: activityLogId);

      state = const AsyncData(null);

      return true;
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);

      return false;
    }
  }

  Future<bool> removeReminder({
    required int leadId,
    required int reminderId,
  }) async {
    state = const AsyncLoading();

    try {
      await ref
          .read(leadsRepositoryProvider)
          .removeReminder(leadId: leadId, reminderId: reminderId);

      state = const AsyncData(null);

      return true;
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);

      return false;
    }
  }

  Future<bool> updateActivity({
    required int leadId,
    required int activityLogId,
    required Map<String, dynamic> payload,
  }) async {
    state = const AsyncLoading();

    try {
      await ref
          .read(leadsRepositoryProvider)
          .updateActivity(
            leadId: leadId,
            activityLogId: activityLogId,
            payload: payload,
          );

      state = const AsyncData(null);

      return true;
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);

      return false;
    }
  }

  Future<bool> updateReminder({
    required int leadId,
    required int reminderId,
    required Map<String, dynamic> payload,
  }) async {
    state = const AsyncLoading();

    try {
      await ref
          .read(leadsRepositoryProvider)
          .updateReminder(
            leadId: leadId,
            reminderId: reminderId,
            payload: payload,
          );

      state = const AsyncData(null);

      return true;
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);

      return false;
    }
  }
}
