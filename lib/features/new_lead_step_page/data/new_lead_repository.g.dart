// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_lead_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$newLeadRepositoryHash() => r'1e6c116827d2c8b1747ff6f5e26a5a5512502c1e';

/// See also [newLeadRepository].
@ProviderFor(newLeadRepository)
final newLeadRepositoryProvider =
    AutoDisposeProvider<NewLeadRepository>.internal(
      newLeadRepository,
      name: r'newLeadRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$newLeadRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NewLeadRepositoryRef = AutoDisposeProviderRef<NewLeadRepository>;
String _$fetchSaleDropdownDataHash() =>
    r'f66ade7ac3bf6bd96686b04125e6191f29329d8a';

/// See also [fetchSaleDropdownData].
@ProviderFor(fetchSaleDropdownData)
final fetchSaleDropdownDataProvider =
    AutoDisposeFutureProvider<SaleDropdownDataResponse>.internal(
      fetchSaleDropdownData,
      name: r'fetchSaleDropdownDataProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$fetchSaleDropdownDataHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchSaleDropdownDataRef =
    AutoDisposeFutureProviderRef<SaleDropdownDataResponse>;
String _$fetchLeadFormConfigHash() =>
    r'41abf67d331af3d4afafde8a4859900b362a7f50';

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

/// See also [fetchLeadFormConfig].
@ProviderFor(fetchLeadFormConfig)
const fetchLeadFormConfigProvider = FetchLeadFormConfigFamily();

/// See also [fetchLeadFormConfig].
class FetchLeadFormConfigFamily
    extends Family<AsyncValue<LeadFormConfigResponse>> {
  /// See also [fetchLeadFormConfig].
  const FetchLeadFormConfigFamily();

  /// See also [fetchLeadFormConfig].
  FetchLeadFormConfigProvider call({required int organizationID}) {
    return FetchLeadFormConfigProvider(organizationID: organizationID);
  }

  @override
  FetchLeadFormConfigProvider getProviderOverride(
    covariant FetchLeadFormConfigProvider provider,
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
  String? get name => r'fetchLeadFormConfigProvider';
}

/// See also [fetchLeadFormConfig].
class FetchLeadFormConfigProvider
    extends AutoDisposeFutureProvider<LeadFormConfigResponse> {
  /// See also [fetchLeadFormConfig].
  FetchLeadFormConfigProvider({required int organizationID})
    : this._internal(
        (ref) => fetchLeadFormConfig(
          ref as FetchLeadFormConfigRef,
          organizationID: organizationID,
        ),
        from: fetchLeadFormConfigProvider,
        name: r'fetchLeadFormConfigProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$fetchLeadFormConfigHash,
        dependencies: FetchLeadFormConfigFamily._dependencies,
        allTransitiveDependencies:
            FetchLeadFormConfigFamily._allTransitiveDependencies,
        organizationID: organizationID,
      );

  FetchLeadFormConfigProvider._internal(
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
    FutureOr<LeadFormConfigResponse> Function(FetchLeadFormConfigRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchLeadFormConfigProvider._internal(
        (ref) => create(ref as FetchLeadFormConfigRef),
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
  AutoDisposeFutureProviderElement<LeadFormConfigResponse> createElement() {
    return _FetchLeadFormConfigProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchLeadFormConfigProvider &&
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
mixin FetchLeadFormConfigRef
    on AutoDisposeFutureProviderRef<LeadFormConfigResponse> {
  /// The parameter `organizationID` of this provider.
  int get organizationID;
}

class _FetchLeadFormConfigProviderElement
    extends AutoDisposeFutureProviderElement<LeadFormConfigResponse>
    with FetchLeadFormConfigRef {
  _FetchLeadFormConfigProviderElement(super.provider);

  @override
  int get organizationID =>
      (origin as FetchLeadFormConfigProvider).organizationID;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
