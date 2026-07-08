// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leads_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$leadsRepositoryHash() => r'223545bdd3dca90f89c3f3196e42adf096988379';

/// See also [leadsRepository].
@ProviderFor(leadsRepository)
final leadsRepositoryProvider = AutoDisposeProvider<LeadsRepository>.internal(
  leadsRepository,
  name: r'leadsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$leadsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LeadsRepositoryRef = AutoDisposeProviderRef<LeadsRepository>;
String _$fetchLeadListHash() => r'78ccc7fa721c219e1e2662decb19a40ddb06830c';

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

/// See also [fetchLeadList].
@ProviderFor(fetchLeadList)
const fetchLeadListProvider = FetchLeadListFamily();

/// See also [fetchLeadList].
class FetchLeadListFamily extends Family<AsyncValue<LeadsResponse>> {
  /// See also [fetchLeadList].
  const FetchLeadListFamily();

  /// See also [fetchLeadList].
  FetchLeadListProvider call({required String uid, String? filterParamName}) {
    return FetchLeadListProvider(uid: uid, filterParamName: filterParamName);
  }

  @override
  FetchLeadListProvider getProviderOverride(
    covariant FetchLeadListProvider provider,
  ) {
    return call(uid: provider.uid, filterParamName: provider.filterParamName);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fetchLeadListProvider';
}

/// See also [fetchLeadList].
class FetchLeadListProvider extends AutoDisposeFutureProvider<LeadsResponse> {
  /// See also [fetchLeadList].
  FetchLeadListProvider({required String uid, String? filterParamName})
    : this._internal(
        (ref) => fetchLeadList(
          ref as FetchLeadListRef,
          uid: uid,
          filterParamName: filterParamName,
        ),
        from: fetchLeadListProvider,
        name: r'fetchLeadListProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$fetchLeadListHash,
        dependencies: FetchLeadListFamily._dependencies,
        allTransitiveDependencies:
            FetchLeadListFamily._allTransitiveDependencies,
        uid: uid,
        filterParamName: filterParamName,
      );

  FetchLeadListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
    required this.filterParamName,
  }) : super.internal();

  final String uid;
  final String? filterParamName;

  @override
  Override overrideWith(
    FutureOr<LeadsResponse> Function(FetchLeadListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchLeadListProvider._internal(
        (ref) => create(ref as FetchLeadListRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
        filterParamName: filterParamName,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<LeadsResponse> createElement() {
    return _FetchLeadListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchLeadListProvider &&
        other.uid == uid &&
        other.filterParamName == filterParamName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);
    hash = _SystemHash.combine(hash, filterParamName.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FetchLeadListRef on AutoDisposeFutureProviderRef<LeadsResponse> {
  /// The parameter `uid` of this provider.
  String get uid;

  /// The parameter `filterParamName` of this provider.
  String? get filterParamName;
}

class _FetchLeadListProviderElement
    extends AutoDisposeFutureProviderElement<LeadsResponse>
    with FetchLeadListRef {
  _FetchLeadListProviderElement(super.provider);

  @override
  String get uid => (origin as FetchLeadListProvider).uid;
  @override
  String? get filterParamName =>
      (origin as FetchLeadListProvider).filterParamName;
}

String _$fetchLeadDetailHash() => r'de47cc613c2a32040c02793d14254c35c9513e31';

/// See also [fetchLeadDetail].
@ProviderFor(fetchLeadDetail)
const fetchLeadDetailProvider = FetchLeadDetailFamily();

/// See also [fetchLeadDetail].
class FetchLeadDetailFamily extends Family<AsyncValue<LeadDetailResponse>> {
  /// See also [fetchLeadDetail].
  const FetchLeadDetailFamily();

  /// See also [fetchLeadDetail].
  FetchLeadDetailProvider call({required String uid, required String leadId}) {
    return FetchLeadDetailProvider(uid: uid, leadId: leadId);
  }

  @override
  FetchLeadDetailProvider getProviderOverride(
    covariant FetchLeadDetailProvider provider,
  ) {
    return call(uid: provider.uid, leadId: provider.leadId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fetchLeadDetailProvider';
}

/// See also [fetchLeadDetail].
class FetchLeadDetailProvider
    extends AutoDisposeFutureProvider<LeadDetailResponse> {
  /// See also [fetchLeadDetail].
  FetchLeadDetailProvider({required String uid, required String leadId})
    : this._internal(
        (ref) => fetchLeadDetail(
          ref as FetchLeadDetailRef,
          uid: uid,
          leadId: leadId,
        ),
        from: fetchLeadDetailProvider,
        name: r'fetchLeadDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$fetchLeadDetailHash,
        dependencies: FetchLeadDetailFamily._dependencies,
        allTransitiveDependencies:
            FetchLeadDetailFamily._allTransitiveDependencies,
        uid: uid,
        leadId: leadId,
      );

  FetchLeadDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
    required this.leadId,
  }) : super.internal();

  final String uid;
  final String leadId;

  @override
  Override overrideWith(
    FutureOr<LeadDetailResponse> Function(FetchLeadDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchLeadDetailProvider._internal(
        (ref) => create(ref as FetchLeadDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
        leadId: leadId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<LeadDetailResponse> createElement() {
    return _FetchLeadDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchLeadDetailProvider &&
        other.uid == uid &&
        other.leadId == leadId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);
    hash = _SystemHash.combine(hash, leadId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FetchLeadDetailRef on AutoDisposeFutureProviderRef<LeadDetailResponse> {
  /// The parameter `uid` of this provider.
  String get uid;

  /// The parameter `leadId` of this provider.
  String get leadId;
}

class _FetchLeadDetailProviderElement
    extends AutoDisposeFutureProviderElement<LeadDetailResponse>
    with FetchLeadDetailRef {
  _FetchLeadDetailProviderElement(super.provider);

  @override
  String get uid => (origin as FetchLeadDetailProvider).uid;
  @override
  String get leadId => (origin as FetchLeadDetailProvider).leadId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
