// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leads_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LeadsController)
final leadsControllerProvider = LeadsControllerProvider._();

final class LeadsControllerProvider
    extends $AsyncNotifierProvider<LeadsController, void> {
  LeadsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'leadsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$leadsControllerHash();

  @$internal
  @override
  LeadsController create() => LeadsController();
}

String _$leadsControllerHash() => r'767ea941c316faa039de846dc8f1b4f7052ff397';

abstract class _$LeadsController extends $AsyncNotifier<void> {
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
