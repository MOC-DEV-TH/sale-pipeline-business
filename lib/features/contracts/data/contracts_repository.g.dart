// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contracts_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(contractsRepository)
final contractsRepositoryProvider = ContractsRepositoryProvider._();

final class ContractsRepositoryProvider
    extends
        $FunctionalProvider<
          ContractsRepository,
          ContractsRepository,
          ContractsRepository
        >
    with $Provider<ContractsRepository> {
  ContractsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contractsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contractsRepositoryHash();

  @$internal
  @override
  $ProviderElement<ContractsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ContractsRepository create(Ref ref) {
    return contractsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ContractsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ContractsRepository>(value),
    );
  }
}

String _$contractsRepositoryHash() =>
    r'254fecd83d620791b9669bd4f2d2b3f8798fbea1';

@ProviderFor(fetchContractList)
final fetchContractListProvider = FetchContractListFamily._();

final class FetchContractListProvider
    extends
        $FunctionalProvider<
          AsyncValue<ContractsResponse>,
          ContractsResponse,
          FutureOr<ContractsResponse>
        >
    with
        $FutureModifier<ContractsResponse>,
        $FutureProvider<ContractsResponse> {
  FetchContractListProvider._({
    required FetchContractListFamily super.from,
    required ({String uid, String? filterParamName}) super.argument,
  }) : super(
         retry: null,
         name: r'fetchContractListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fetchContractListHash();

  @override
  String toString() {
    return r'fetchContractListProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<ContractsResponse> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ContractsResponse> create(Ref ref) {
    final argument = this.argument as ({String uid, String? filterParamName});
    return fetchContractList(
      ref,
      uid: argument.uid,
      filterParamName: argument.filterParamName,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FetchContractListProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchContractListHash() => r'5742e30d3c08a8e8c4cd4b597743107c2b5e3dfe';

final class FetchContractListFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<ContractsResponse>,
          ({String uid, String? filterParamName})
        > {
  FetchContractListFamily._()
    : super(
        retry: null,
        name: r'fetchContractListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FetchContractListProvider call({
    required String uid,
    String? filterParamName,
  }) => FetchContractListProvider._(
    argument: (uid: uid, filterParamName: filterParamName),
    from: this,
  );

  @override
  String toString() => r'fetchContractListProvider';
}

@ProviderFor(fetchContractedLeadDetail)
final fetchContractedLeadDetailProvider = FetchContractedLeadDetailFamily._();

final class FetchContractedLeadDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<ContractedDetailResponse>,
          ContractedDetailResponse,
          FutureOr<ContractedDetailResponse>
        >
    with
        $FutureModifier<ContractedDetailResponse>,
        $FutureProvider<ContractedDetailResponse> {
  FetchContractedLeadDetailProvider._({
    required FetchContractedLeadDetailFamily super.from,
    required ({String uid, String profileId}) super.argument,
  }) : super(
         retry: null,
         name: r'fetchContractedLeadDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fetchContractedLeadDetailHash();

  @override
  String toString() {
    return r'fetchContractedLeadDetailProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<ContractedDetailResponse> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ContractedDetailResponse> create(Ref ref) {
    final argument = this.argument as ({String uid, String profileId});
    return fetchContractedLeadDetail(
      ref,
      uid: argument.uid,
      profileId: argument.profileId,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FetchContractedLeadDetailProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchContractedLeadDetailHash() =>
    r'9df251d3a44ba50a9fed6172b175a0d4277fd63c';

final class FetchContractedLeadDetailFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<ContractedDetailResponse>,
          ({String uid, String profileId})
        > {
  FetchContractedLeadDetailFamily._()
    : super(
        retry: null,
        name: r'fetchContractedLeadDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FetchContractedLeadDetailProvider call({
    required String uid,
    required String profileId,
  }) => FetchContractedLeadDetailProvider._(
    argument: (uid: uid, profileId: profileId),
    from: this,
  );

  @override
  String toString() => r'fetchContractedLeadDetailProvider';
}
