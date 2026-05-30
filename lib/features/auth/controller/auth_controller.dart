import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/auth_repository.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  bool mounted = true;

  @override
  FutureOr<void> build() {
    /// * this code is for  preventing error caused by popping out or going to other screen while the app is sending fcm request
    ref.onDispose(() => mounted = false);
  }

  Future<bool> login({required String userId, required String password}) async {
    final authRepository = ref.read(authRepositoryNoTokenProvider);
    state = const AsyncValue.loading();
    final result = await AsyncValue.guard(
          () => authRepository.login(userId: userId, password: password),
    );
    if (mounted) {
      state = result;
    }

    return state.hasError == false;
  }
}
