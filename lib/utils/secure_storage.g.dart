// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secure_storage.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(secureStorage)
final secureStorageProvider = SecureStorageProvider._();

final class SecureStorageProvider
    extends $FunctionalProvider<SecureStorage, SecureStorage, SecureStorage>
    with $Provider<SecureStorage> {
  SecureStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'secureStorageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$secureStorageHash();

  @$internal
  @override
  $ProviderElement<SecureStorage> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SecureStorage create(Ref ref) {
    return secureStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SecureStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SecureStorage>(value),
    );
  }
}

String _$secureStorageHash() => r'5c9908c0046ad0e39469ee7acbb5540397b36693';

@ProviderFor(getAuthStatus)
final getAuthStatusProvider = GetAuthStatusProvider._();

final class GetAuthStatusProvider
    extends $FunctionalProvider<AsyncValue<String?>, String?, FutureOr<String?>>
    with $FutureModifier<String?>, $FutureProvider<String?> {
  GetAuthStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getAuthStatusProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getAuthStatusHash();

  @$internal
  @override
  $FutureProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String?> create(Ref ref) {
    return getAuthStatus(ref);
  }
}

String _$getAuthStatusHash() => r'8f82aac554741b73e8086b2b66e8eea45238f6e5';

@ProviderFor(getUserName)
final getUserNameProvider = GetUserNameProvider._();

final class GetUserNameProvider
    extends $FunctionalProvider<String?, String?, String?>
    with $Provider<String?> {
  GetUserNameProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getUserNameProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getUserNameHash();

  @$internal
  @override
  $ProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String? create(Ref ref) {
    return getUserName(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$getUserNameHash() => r'cef0b97547d7d183e7436146e98cf211e5a5f33d';

@ProviderFor(getFcmToken)
final getFcmTokenProvider = GetFcmTokenProvider._();

final class GetFcmTokenProvider
    extends $FunctionalProvider<String?, String?, String?>
    with $Provider<String?> {
  GetFcmTokenProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getFcmTokenProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getFcmTokenHash();

  @$internal
  @override
  $ProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String? create(Ref ref) {
    return getFcmToken(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$getFcmTokenHash() => r'2dd4acf4b7454f583fb997ac9f6a6ed4b632f2c5';

@ProviderFor(getUid)
final getUidProvider = GetUidProvider._();

final class GetUidProvider
    extends $FunctionalProvider<String?, String?, String?>
    with $Provider<String?> {
  GetUidProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getUidProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getUidHash();

  @$internal
  @override
  $ProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String? create(Ref ref) {
    return getUid(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$getUidHash() => r'7cdbf53f4c51bb867fdc16e06f8cbf92fc3f6bfc';

@ProviderFor(getAuthToken)
final getAuthTokenProvider = GetAuthTokenProvider._();

final class GetAuthTokenProvider
    extends $FunctionalProvider<String?, String?, String?>
    with $Provider<String?> {
  GetAuthTokenProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getAuthTokenProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getAuthTokenHash();

  @$internal
  @override
  $ProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String? create(Ref ref) {
    return getAuthToken(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$getAuthTokenHash() => r'3943a969ee107f5fecbbbb5eb5ab448701353b3e';

@ProviderFor(getBaseApiUrl)
final getBaseApiUrlProvider = GetBaseApiUrlProvider._();

final class GetBaseApiUrlProvider
    extends $FunctionalProvider<String?, String?, String?>
    with $Provider<String?> {
  GetBaseApiUrlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getBaseApiUrlProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getBaseApiUrlHash();

  @$internal
  @override
  $ProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String? create(Ref ref) {
    return getBaseApiUrl(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$getBaseApiUrlHash() => r'5cf577111298ce4149af920796a84da74d5a7d1c';
