// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_lead_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(newLeadRepository)
final newLeadRepositoryProvider = NewLeadRepositoryProvider._();

final class NewLeadRepositoryProvider
    extends
        $FunctionalProvider<
          NewLeadRepository,
          NewLeadRepository,
          NewLeadRepository
        >
    with $Provider<NewLeadRepository> {
  NewLeadRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'newLeadRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$newLeadRepositoryHash();

  @$internal
  @override
  $ProviderElement<NewLeadRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NewLeadRepository create(Ref ref) {
    return newLeadRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NewLeadRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NewLeadRepository>(value),
    );
  }
}

String _$newLeadRepositoryHash() => r'bf0c5f087499342ec4cc230a44d5ebf9ebaccfed';

@ProviderFor(fetchSaleDropdownData)
final fetchSaleDropdownDataProvider = FetchSaleDropdownDataProvider._();

final class FetchSaleDropdownDataProvider
    extends
        $FunctionalProvider<
          AsyncValue<SaleDropdownDataResponse>,
          SaleDropdownDataResponse,
          FutureOr<SaleDropdownDataResponse>
        >
    with
        $FutureModifier<SaleDropdownDataResponse>,
        $FutureProvider<SaleDropdownDataResponse> {
  FetchSaleDropdownDataProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fetchSaleDropdownDataProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fetchSaleDropdownDataHash();

  @$internal
  @override
  $FutureProviderElement<SaleDropdownDataResponse> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SaleDropdownDataResponse> create(Ref ref) {
    return fetchSaleDropdownData(ref);
  }
}

String _$fetchSaleDropdownDataHash() =>
    r'99bf5c55cbd48aba9ece48da0bdb3c5528fa9cdb';

@ProviderFor(fetchLeadFormConfig)
final fetchLeadFormConfigProvider = FetchLeadFormConfigFamily._();

final class FetchLeadFormConfigProvider
    extends
        $FunctionalProvider<
          AsyncValue<LeadFormConfigResponse>,
          LeadFormConfigResponse,
          FutureOr<LeadFormConfigResponse>
        >
    with
        $FutureModifier<LeadFormConfigResponse>,
        $FutureProvider<LeadFormConfigResponse> {
  FetchLeadFormConfigProvider._({
    required FetchLeadFormConfigFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'fetchLeadFormConfigProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fetchLeadFormConfigHash();

  @override
  String toString() {
    return r'fetchLeadFormConfigProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<LeadFormConfigResponse> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<LeadFormConfigResponse> create(Ref ref) {
    final argument = this.argument as int;
    return fetchLeadFormConfig(ref, organizationID: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchLeadFormConfigProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchLeadFormConfigHash() =>
    r'9734588aa3a36b9fc3888a301837b0ee3d183437';

final class FetchLeadFormConfigFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<LeadFormConfigResponse>, int> {
  FetchLeadFormConfigFamily._()
    : super(
        retry: null,
        name: r'fetchLeadFormConfigProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FetchLeadFormConfigProvider call({required int organizationID}) =>
      FetchLeadFormConfigProvider._(argument: organizationID, from: this);

  @override
  String toString() => r'fetchLeadFormConfigProvider';
}
