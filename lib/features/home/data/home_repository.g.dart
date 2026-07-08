// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$homeRepositoryHash() => r'29e398f1f8843bc28c6e5def3e007fe733f2ba23';

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
String _$fetchActivityOverviewHash() =>
    r'f97586a176a2d49df816f0aab143b5f1b758517b';

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

/// See also [fetchActivityOverview].
@ProviderFor(fetchActivityOverview)
const fetchActivityOverviewProvider = FetchActivityOverviewFamily();

/// See also [fetchActivityOverview].
class FetchActivityOverviewFamily
    extends Family<AsyncValue<ActivityOverviewResponse>> {
  /// See also [fetchActivityOverview].
  const FetchActivityOverviewFamily();

  /// See also [fetchActivityOverview].
  FetchActivityOverviewProvider call({required String uid}) {
    return FetchActivityOverviewProvider(uid: uid);
  }

  @override
  FetchActivityOverviewProvider getProviderOverride(
    covariant FetchActivityOverviewProvider provider,
  ) {
    return call(uid: provider.uid);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fetchActivityOverviewProvider';
}

/// See also [fetchActivityOverview].
class FetchActivityOverviewProvider
    extends AutoDisposeFutureProvider<ActivityOverviewResponse> {
  /// See also [fetchActivityOverview].
  FetchActivityOverviewProvider({required String uid})
    : this._internal(
        (ref) =>
            fetchActivityOverview(ref as FetchActivityOverviewRef, uid: uid),
        from: fetchActivityOverviewProvider,
        name: r'fetchActivityOverviewProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$fetchActivityOverviewHash,
        dependencies: FetchActivityOverviewFamily._dependencies,
        allTransitiveDependencies:
            FetchActivityOverviewFamily._allTransitiveDependencies,
        uid: uid,
      );

  FetchActivityOverviewProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
  }) : super.internal();

  final String uid;

  @override
  Override overrideWith(
    FutureOr<ActivityOverviewResponse> Function(
      FetchActivityOverviewRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchActivityOverviewProvider._internal(
        (ref) => create(ref as FetchActivityOverviewRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ActivityOverviewResponse> createElement() {
    return _FetchActivityOverviewProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchActivityOverviewProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FetchActivityOverviewRef
    on AutoDisposeFutureProviderRef<ActivityOverviewResponse> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _FetchActivityOverviewProviderElement
    extends AutoDisposeFutureProviderElement<ActivityOverviewResponse>
    with FetchActivityOverviewRef {
  _FetchActivityOverviewProviderElement(super.provider);

  @override
  String get uid => (origin as FetchActivityOverviewProvider).uid;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
