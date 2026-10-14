// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(homeRepository)
final homeRepositoryProvider = HomeRepositoryProvider._();

final class HomeRepositoryProvider
    extends $FunctionalProvider<HomeRepository, HomeRepository, HomeRepository>
    with $Provider<HomeRepository> {
  HomeRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeRepositoryHash();

  @$internal
  @override
  $ProviderElement<HomeRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HomeRepository create(Ref ref) {
    return homeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeRepository>(value),
    );
  }
}

String _$homeRepositoryHash() => r'f8ece09654d1d23a79c203f3fb4dcf7b04e7ca85';

@ProviderFor(fetchReportSummaryByOrganizationID)
final fetchReportSummaryByOrganizationIDProvider =
    FetchReportSummaryByOrganizationIDFamily._();

final class FetchReportSummaryByOrganizationIDProvider
    extends
        $FunctionalProvider<
          AsyncValue<ReportSummaryResponse>,
          ReportSummaryResponse,
          FutureOr<ReportSummaryResponse>
        >
    with
        $FutureModifier<ReportSummaryResponse>,
        $FutureProvider<ReportSummaryResponse> {
  FetchReportSummaryByOrganizationIDProvider._({
    required FetchReportSummaryByOrganizationIDFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'fetchReportSummaryByOrganizationIDProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() =>
      _$fetchReportSummaryByOrganizationIDHash();

  @override
  String toString() {
    return r'fetchReportSummaryByOrganizationIDProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ReportSummaryResponse> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ReportSummaryResponse> create(Ref ref) {
    final argument = this.argument as int;
    return fetchReportSummaryByOrganizationID(ref, organizationID: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchReportSummaryByOrganizationIDProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchReportSummaryByOrganizationIDHash() =>
    r'd79f7a124e87cb75e195a364cf2735082a72c53f';

final class FetchReportSummaryByOrganizationIDFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ReportSummaryResponse>, int> {
  FetchReportSummaryByOrganizationIDFamily._()
    : super(
        retry: null,
        name: r'fetchReportSummaryByOrganizationIDProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FetchReportSummaryByOrganizationIDProvider call({
    required int organizationID,
  }) => FetchReportSummaryByOrganizationIDProvider._(
    argument: organizationID,
    from: this,
  );

  @override
  String toString() => r'fetchReportSummaryByOrganizationIDProvider';
}
