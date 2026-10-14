// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_lead_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NewLeadController)
final newLeadControllerProvider = NewLeadControllerProvider._();

final class NewLeadControllerProvider
    extends $AsyncNotifierProvider<NewLeadController, void> {
  NewLeadControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'newLeadControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$newLeadControllerHash();

  @$internal
  @override
  NewLeadController create() => NewLeadController();
}

String _$newLeadControllerHash() => r'4e230f9488e988fa9ef45eb28c0640a7ef4e8c5d';

abstract class _$NewLeadController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
