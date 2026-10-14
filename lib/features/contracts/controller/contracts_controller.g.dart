// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contracts_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ContractsController)
final contractsControllerProvider = ContractsControllerProvider._();

final class ContractsControllerProvider
    extends $AsyncNotifierProvider<ContractsController, void> {
  ContractsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contractsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contractsControllerHash();

  @$internal
  @override
  ContractsController create() => ContractsController();
}

String _$contractsControllerHash() =>
    r'530cb7478dbfc717acca9fd04fb0751b49e99164';

abstract class _$ContractsController extends $AsyncNotifier<void> {
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
