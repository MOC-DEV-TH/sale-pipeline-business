// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'choose_task_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// ============================================================
/// REPOSITORY
/// ============================================================

@ProviderFor(chooseTaskRepository)
final chooseTaskRepositoryProvider = ChooseTaskRepositoryProvider._();

/// ============================================================
/// REPOSITORY
/// ============================================================

final class ChooseTaskRepositoryProvider
    extends
        $FunctionalProvider<
          ChooseTaskRepository,
          ChooseTaskRepository,
          ChooseTaskRepository
        >
    with $Provider<ChooseTaskRepository> {
  /// ============================================================
  /// REPOSITORY
  /// ============================================================
  ChooseTaskRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chooseTaskRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chooseTaskRepositoryHash();

  @$internal
  @override
  $ProviderElement<ChooseTaskRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ChooseTaskRepository create(Ref ref) {
    return chooseTaskRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChooseTaskRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChooseTaskRepository>(value),
    );
  }
}

String _$chooseTaskRepositoryHash() =>
    r'7ca5c79b92831767cd0e313675a9b0df6320bf68';

/// ============================================================
/// ORGANIZATION LIST
/// ============================================================

@ProviderFor(fetchOrganizationList)
final fetchOrganizationListProvider = FetchOrganizationListProvider._();

/// ============================================================
/// ORGANIZATION LIST
/// ============================================================

final class FetchOrganizationListProvider
    extends
        $FunctionalProvider<
          AsyncValue<OrganizationsResponse?>,
          OrganizationsResponse?,
          FutureOr<OrganizationsResponse?>
        >
    with
        $FutureModifier<OrganizationsResponse?>,
        $FutureProvider<OrganizationsResponse?> {
  /// ============================================================
  /// ORGANIZATION LIST
  /// ============================================================
  FetchOrganizationListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fetchOrganizationListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fetchOrganizationListHash();

  @$internal
  @override
  $FutureProviderElement<OrganizationsResponse?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<OrganizationsResponse?> create(Ref ref) {
    return fetchOrganizationList(ref);
  }
}

String _$fetchOrganizationListHash() =>
    r'fd20b03fa1dc1f7eb47d19581c3570c780e6e8b5';
