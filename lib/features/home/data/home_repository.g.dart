// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$homeRepositoryHash() => r'82228ecbf145da75f6eb34887a374f5f760b4355';

/// See also [homeRepository].
@ProviderFor(homeRepository)
final homeRepositoryProvider = AutoDisposeProvider<HomeRepository>.internal(
  homeRepository,
  name: r'homeRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homeRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HomeRepositoryRef = AutoDisposeProviderRef<HomeRepository>;
String _$fetchReportSummaryByOrganizationIDHash() =>
    r'8233419a3cd5195254ce912b68261e9e31afced4';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [fetchReportSummaryByOrganizationID].
@ProviderFor(fetchReportSummaryByOrganizationID)
const fetchReportSummaryByOrganizationIDProvider =
    FetchReportSummaryByOrganizationIDFamily();

/// See also [fetchReportSummaryByOrganizationID].
class FetchReportSummaryByOrganizationIDFamily
    extends Family<AsyncValue<ReportSummaryResponse>> {
  /// See also [fetchReportSummaryByOrganizationID].
  const FetchReportSummaryByOrganizationIDFamily();

  /// See also [fetchReportSummaryByOrganizationID].
  FetchReportSummaryByOrganizationIDProvider call({
    required int organizationID,
  }) {
    return FetchReportSummaryByOrganizationIDProvider(
      organizationID: organizationID,
    );
  }

  @override
  FetchReportSummaryByOrganizationIDProvider getProviderOverride(
    covariant FetchReportSummaryByOrganizationIDProvider provider,
  ) {
    return call(organizationID: provider.organizationID);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fetchReportSummaryByOrganizationIDProvider';
}

/// See also [fetchReportSummaryByOrganizationID].
class FetchReportSummaryByOrganizationIDProvider
    extends AutoDisposeFutureProvider<ReportSummaryResponse> {
  /// See also [fetchReportSummaryByOrganizationID].
  FetchReportSummaryByOrganizationIDProvider({required int organizationID})
    : this._internal(
        (ref) => fetchReportSummaryByOrganizationID(
          ref as FetchReportSummaryByOrganizationIDRef,
          organizationID: organizationID,
        ),
        from: fetchReportSummaryByOrganizationIDProvider,
        name: r'fetchReportSummaryByOrganizationIDProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$fetchReportSummaryByOrganizationIDHash,
        dependencies: FetchReportSummaryByOrganizationIDFamily._dependencies,
        allTransitiveDependencies:
            FetchReportSummaryByOrganizationIDFamily._allTransitiveDependencies,
        organizationID: organizationID,
      );

  FetchReportSummaryByOrganizationIDProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.organizationID,
  }) : super.internal();

  final int organizationID;

  @override
  Override overrideWith(
    FutureOr<ReportSummaryResponse> Function(
      FetchReportSummaryByOrganizationIDRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchReportSummaryByOrganizationIDProvider._internal(
        (ref) => create(ref as FetchReportSummaryByOrganizationIDRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        organizationID: organizationID,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ReportSummaryResponse> createElement() {
    return _FetchReportSummaryByOrganizationIDProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchReportSummaryByOrganizationIDProvider &&
        other.organizationID == organizationID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, organizationID.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FetchReportSummaryByOrganizationIDRef
    on AutoDisposeFutureProviderRef<ReportSummaryResponse> {
  /// The parameter `organizationID` of this provider.
  int get organizationID;
}

class _FetchReportSummaryByOrganizationIDProviderElement
    extends AutoDisposeFutureProviderElement<ReportSummaryResponse>
    with FetchReportSummaryByOrganizationIDRef {
  _FetchReportSummaryByOrganizationIDProviderElement(super.provider);

  @override
  int get organizationID =>
      (origin as FetchReportSummaryByOrganizationIDProvider).organizationID;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
