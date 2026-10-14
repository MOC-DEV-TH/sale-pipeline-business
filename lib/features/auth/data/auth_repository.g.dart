// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authRepositoryNoToken)
final authRepositoryNoTokenProvider = AuthRepositoryNoTokenProvider._();

final class AuthRepositoryNoTokenProvider
    extends $FunctionalProvider<AuthRepository, AuthRepository, AuthRepository>
    with $Provider<AuthRepository> {
  AuthRepositoryNoTokenProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRepositoryNoTokenProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRepositoryNoTokenHash();

  @$internal
  @override
  $ProviderElement<AuthRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthRepository create(Ref ref) {
    return authRepositoryNoToken(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRepository>(value),
    );
  }
}

String _$authRepositoryNoTokenHash() =>
    r'10c1191e09f5fc68a67e36c418ad58754e4ce6db';
