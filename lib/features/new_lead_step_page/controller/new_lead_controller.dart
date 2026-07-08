import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/new_lead_repository.dart';

part 'new_lead_controller.g.dart';

@riverpod
class NewLeadController extends _$NewLeadController {
  bool _mounted = true;

  @override
  FutureOr<void> build() {
    ref.onDispose(() => _mounted = false);
  }

  Future<dynamic> submitLead({
    required Map<String, dynamic> payload,
  }) async {
    final repo = ref.read(newLeadRepositoryProvider);

    state = const AsyncValue.loading();

    final result = await AsyncValue.guard(() {
      return repo.submitLead(payload: payload);
    });

    if (_mounted) {
      state = result.hasError
          ? AsyncValue.error(result.error!, result.stackTrace!)
          : const AsyncValue.data(null);
    }

    return result.valueOrNull;
  }
}