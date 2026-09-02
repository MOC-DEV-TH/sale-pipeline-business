// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contracts_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$contractsRepositoryHash() =>
    r'6db68a37761b8dff0a78b289f3e64a1f50c7188c';

/// See also [contractsRepository].
@ProviderFor(contractsRepository)
final contractsRepositoryProvider =
    AutoDisposeProvider<ContractsRepository>.internal(
      contractsRepository,
      name: r'contractsRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$contractsRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ContractsRepositoryRef = AutoDisposeProviderRef<ContractsRepository>;
String _$fetchContractListHash() => r'a696dac0ae61ee728ca316a036acb060f571d3ea';

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

/// See also [fetchContractList].
@ProviderFor(fetchContractList)
const fetchContractListProvider = FetchContractListFamily();

/// See also [fetchContractList].
class FetchContractListFamily extends Family<AsyncValue<ContractsResponse>> {
  /// See also [fetchContractList].
  const FetchContractListFamily();

  /// See also [fetchContractList].
  FetchContractListProvider call({
    required String uid,
    String? filterParamName,
  }) {
    return FetchContractListProvider(
      uid: uid,
      filterParamName: filterParamName,
    );
  }

  @override
  FetchContractListProvider getProviderOverride(
    covariant FetchContractListProvider provider,
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
  String? get name => r'fetchContractListProvider';
}

/// See also [fetchContractList].
class FetchContractListProvider
    extends AutoDisposeFutureProvider<ContractsResponse> {
  /// See also [fetchContractList].
  FetchContractListProvider({required String uid, String? filterParamName})
    : this._internal(
        (ref) => fetchContractList(
          ref as FetchContractListRef,
          uid: uid,
          filterParamName: filterParamName,
        ),
        from: fetchContractListProvider,
        name: r'fetchContractListProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$fetchContractListHash,
        dependencies: FetchContractListFamily._dependencies,
        allTransitiveDependencies:
            FetchContractListFamily._allTransitiveDependencies,
        uid: uid,
        filterParamName: filterParamName,
      );

  FetchContractListProvider._internal(
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
    FutureOr<ContractsResponse> Function(FetchContractListRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchContractListProvider._internal(
        (ref) => create(ref as FetchContractListRef),
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
  AutoDisposeFutureProviderElement<ContractsResponse> createElement() {
    return _FetchContractListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchContractListProvider &&
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
mixin FetchContractListRef on AutoDisposeFutureProviderRef<ContractsResponse> {
  /// The parameter `uid` of this provider.
  String get uid;

  /// The parameter `filterParamName` of this provider.
  String? get filterParamName;
}

class _FetchContractListProviderElement
    extends AutoDisposeFutureProviderElement<ContractsResponse>
    with FetchContractListRef {
  _FetchContractListProviderElement(super.provider);

  @override
  String get uid => (origin as FetchContractListProvider).uid;
  @override
  String? get filterParamName =>
      (origin as FetchContractListProvider).filterParamName;
}

String _$fetchContractedLeadDetailHash() =>
    r'86beb95cabd15b3387f708e4b902d474c4b7e6b2';

/// See also [fetchContractedLeadDetail].
@ProviderFor(fetchContractedLeadDetail)
const fetchContractedLeadDetailProvider = FetchContractedLeadDetailFamily();

/// See also [fetchContractedLeadDetail].
class FetchContractedLeadDetailFamily
    extends Family<AsyncValue<ContractedDetailResponse>> {
  /// See also [fetchContractedLeadDetail].
  const FetchContractedLeadDetailFamily();

  /// See also [fetchContractedLeadDetail].
  FetchContractedLeadDetailProvider call({
    required String uid,
    required String profileId,
  }) {
    return FetchContractedLeadDetailProvider(uid: uid, profileId: profileId);
  }

  @override
  FetchContractedLeadDetailProvider getProviderOverride(
    covariant FetchContractedLeadDetailProvider provider,
  ) {
    return call(uid: provider.uid, profileId: provider.profileId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fetchContractedLeadDetailProvider';
}

/// See also [fetchContractedLeadDetail].
class FetchContractedLeadDetailProvider
    extends AutoDisposeFutureProvider<ContractedDetailResponse> {
  /// See also [fetchContractedLeadDetail].
  FetchContractedLeadDetailProvider({
    required String uid,
    required String profileId,
  }) : this._internal(
         (ref) => fetchContractedLeadDetail(
           ref as FetchContractedLeadDetailRef,
           uid: uid,
           profileId: profileId,
         ),
         from: fetchContractedLeadDetailProvider,
         name: r'fetchContractedLeadDetailProvider',
         debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
             ? null
             : _$fetchContractedLeadDetailHash,
         dependencies: FetchContractedLeadDetailFamily._dependencies,
         allTransitiveDependencies:
             FetchContractedLeadDetailFamily._allTransitiveDependencies,
         uid: uid,
         profileId: profileId,
       );

  FetchContractedLeadDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
    required this.profileId,
  }) : super.internal();

  final String uid;
  final String profileId;

  @override
  Override overrideWith(
    FutureOr<ContractedDetailResponse> Function(
      FetchContractedLeadDetailRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchContractedLeadDetailProvider._internal(
        (ref) => create(ref as FetchContractedLeadDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
        profileId: profileId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ContractedDetailResponse> createElement() {
    return _FetchContractedLeadDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchContractedLeadDetailProvider &&
        other.uid == uid &&
        other.profileId == profileId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);
    hash = _SystemHash.combine(hash, profileId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FetchContractedLeadDetailRef
    on AutoDisposeFutureProviderRef<ContractedDetailResponse> {
  /// The parameter `uid` of this provider.
  String get uid;

  /// The parameter `profileId` of this provider.
  String get profileId;
}

class _FetchContractedLeadDetailProviderElement
    extends AutoDisposeFutureProviderElement<ContractedDetailResponse>
    with FetchContractedLeadDetailRef {
  _FetchContractedLeadDetailProviderElement(super.provider);

  @override
  String get uid => (origin as FetchContractedLeadDetailProvider).uid;
  @override
  String get profileId =>
      (origin as FetchContractedLeadDetailProvider).profileId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
