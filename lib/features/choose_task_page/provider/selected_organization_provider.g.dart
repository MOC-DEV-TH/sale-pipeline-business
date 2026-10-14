// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_organization_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedOrganization)
final selectedOrganizationProvider = SelectedOrganizationProvider._();

final class SelectedOrganizationProvider
    extends $NotifierProvider<SelectedOrganization, OrganizationVO?> {
  SelectedOrganizationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedOrganizationProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedOrganizationHash();

  @$internal
  @override
  SelectedOrganization create() => SelectedOrganization();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OrganizationVO? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OrganizationVO?>(value),
    );
  }
}

String _$selectedOrganizationHash() =>
    r'cfa01c69785d9fd801c295f32fcb38b7e33a5967';

abstract class _$SelectedOrganization extends $Notifier<OrganizationVO?> {
  OrganizationVO? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<OrganizationVO?, OrganizationVO?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<OrganizationVO?, OrganizationVO?>,
              OrganizationVO?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
