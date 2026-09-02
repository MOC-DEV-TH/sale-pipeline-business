// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leads_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$leadsRepositoryHash() => r'e427a6e0b654e649667b8cde9cb3fae524aa8e48';

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
String _$fetchLeadDetailHash() => r'de47cc613c2a32040c02793d14254c35c9513e31';

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

String _$fetchLeadsByOrganizationIDHash() =>
    r'f5a289abe5f2c737a24762e34166ce7f7fa33b20';

/// See also [fetchLeadsByOrganizationID].
@ProviderFor(fetchLeadsByOrganizationID)
const fetchLeadsByOrganizationIDProvider = FetchLeadsByOrganizationIDFamily();

/// See also [fetchLeadsByOrganizationID].
class FetchLeadsByOrganizationIDFamily
    extends Family<AsyncValue<LeadsResponse>> {
  /// See also [fetchLeadsByOrganizationID].
  const FetchLeadsByOrganizationIDFamily();

  /// See also [fetchLeadsByOrganizationID].
  FetchLeadsByOrganizationIDProvider call({
    required int organizationID,
    required int pageNo,
  }) {
    return FetchLeadsByOrganizationIDProvider(
      organizationID: organizationID,
      pageNo: pageNo,
    );
  }

  @override
  FetchLeadsByOrganizationIDProvider getProviderOverride(
    covariant FetchLeadsByOrganizationIDProvider provider,
  ) {
    return call(
      organizationID: provider.organizationID,
      pageNo: provider.pageNo,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fetchLeadsByOrganizationIDProvider';
}

/// See also [fetchLeadsByOrganizationID].
class FetchLeadsByOrganizationIDProvider
    extends AutoDisposeFutureProvider<LeadsResponse> {
  /// See also [fetchLeadsByOrganizationID].
  FetchLeadsByOrganizationIDProvider({
    required int organizationID,
    required int pageNo,
  }) : this._internal(
         (ref) => fetchLeadsByOrganizationID(
           ref as FetchLeadsByOrganizationIDRef,
           organizationID: organizationID,
           pageNo: pageNo,
         ),
         from: fetchLeadsByOrganizationIDProvider,
         name: r'fetchLeadsByOrganizationIDProvider',
         debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
             ? null
             : _$fetchLeadsByOrganizationIDHash,
         dependencies: FetchLeadsByOrganizationIDFamily._dependencies,
         allTransitiveDependencies:
             FetchLeadsByOrganizationIDFamily._allTransitiveDependencies,
         organizationID: organizationID,
         pageNo: pageNo,
       );

  FetchLeadsByOrganizationIDProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.organizationID,
    required this.pageNo,
  }) : super.internal();

  final int organizationID;
  final int pageNo;

  @override
  Override overrideWith(
    FutureOr<LeadsResponse> Function(FetchLeadsByOrganizationIDRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchLeadsByOrganizationIDProvider._internal(
        (ref) => create(ref as FetchLeadsByOrganizationIDRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        organizationID: organizationID,
        pageNo: pageNo,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<LeadsResponse> createElement() {
    return _FetchLeadsByOrganizationIDProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchLeadsByOrganizationIDProvider &&
        other.organizationID == organizationID &&
        other.pageNo == pageNo;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, organizationID.hashCode);
    hash = _SystemHash.combine(hash, pageNo.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FetchLeadsByOrganizationIDRef
    on AutoDisposeFutureProviderRef<LeadsResponse> {
  /// The parameter `organizationID` of this provider.
  int get organizationID;

  /// The parameter `pageNo` of this provider.
  int get pageNo;
}

class _FetchLeadsByOrganizationIDProviderElement
    extends AutoDisposeFutureProviderElement<LeadsResponse>
    with FetchLeadsByOrganizationIDRef {
  _FetchLeadsByOrganizationIDProviderElement(super.provider);

  @override
  int get organizationID =>
      (origin as FetchLeadsByOrganizationIDProvider).organizationID;
  @override
  int get pageNo => (origin as FetchLeadsByOrganizationIDProvider).pageNo;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
