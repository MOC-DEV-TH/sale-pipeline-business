// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leads_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(leadsRepository)
final leadsRepositoryProvider = LeadsRepositoryProvider._();

final class LeadsRepositoryProvider
    extends
        $FunctionalProvider<LeadsRepository, LeadsRepository, LeadsRepository>
    with $Provider<LeadsRepository> {
  LeadsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'leadsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$leadsRepositoryHash();

  @$internal
  @override
  $ProviderElement<LeadsRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LeadsRepository create(Ref ref) {
    return leadsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LeadsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LeadsRepository>(value),
    );
  }
}

String _$leadsRepositoryHash() => r'1409a170f6b51ea521fded26db6b632b95693a6d';

@ProviderFor(fetchLeadDetail)
final fetchLeadDetailProvider = FetchLeadDetailFamily._();

final class FetchLeadDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<LeadDetailsResponse>,
          LeadDetailsResponse,
          FutureOr<LeadDetailsResponse>
        >
    with
        $FutureModifier<LeadDetailsResponse>,
        $FutureProvider<LeadDetailsResponse> {
  FetchLeadDetailProvider._({
    required FetchLeadDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'fetchLeadDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fetchLeadDetailHash();

  @override
  String toString() {
    return r'fetchLeadDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<LeadDetailsResponse> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<LeadDetailsResponse> create(Ref ref) {
    final argument = this.argument as int;
    return fetchLeadDetail(ref, leadId: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchLeadDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchLeadDetailHash() => r'880932565fc78df9236ba641bff7fd2bc99ff55d';

final class FetchLeadDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<LeadDetailsResponse>, int> {
  FetchLeadDetailFamily._()
    : super(
        retry: null,
        name: r'fetchLeadDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FetchLeadDetailProvider call({required int leadId}) =>
      FetchLeadDetailProvider._(argument: leadId, from: this);

  @override
  String toString() => r'fetchLeadDetailProvider';
}

@ProviderFor(fetchLeadsByOrganizationID)
final fetchLeadsByOrganizationIDProvider = FetchLeadsByOrganizationIDFamily._();

final class FetchLeadsByOrganizationIDProvider
    extends
        $FunctionalProvider<
          AsyncValue<LeadsResponse>,
          LeadsResponse,
          FutureOr<LeadsResponse>
        >
    with $FutureModifier<LeadsResponse>, $FutureProvider<LeadsResponse> {
  FetchLeadsByOrganizationIDProvider._({
    required FetchLeadsByOrganizationIDFamily super.from,
    required ({int organizationID, int pageNo}) super.argument,
  }) : super(
         retry: null,
         name: r'fetchLeadsByOrganizationIDProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fetchLeadsByOrganizationIDHash();

  @override
  String toString() {
    return r'fetchLeadsByOrganizationIDProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<LeadsResponse> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<LeadsResponse> create(Ref ref) {
    final argument = this.argument as ({int organizationID, int pageNo});
    return fetchLeadsByOrganizationID(
      ref,
      organizationID: argument.organizationID,
      pageNo: argument.pageNo,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is FetchLeadsByOrganizationIDProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchLeadsByOrganizationIDHash() =>
    r'2f2ecdc050a3f9f72966f9a256596841d79ef295';

final class FetchLeadsByOrganizationIDFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<LeadsResponse>,
          ({int organizationID, int pageNo})
        > {
  FetchLeadsByOrganizationIDFamily._()
    : super(
        retry: null,
        name: r'fetchLeadsByOrganizationIDProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FetchLeadsByOrganizationIDProvider call({
    required int organizationID,
    required int pageNo,
  }) => FetchLeadsByOrganizationIDProvider._(
    argument: (organizationID: organizationID, pageNo: pageNo),
    from: this,
  );

  @override
  String toString() => r'fetchLeadsByOrganizationIDProvider';
}

/// ===========================================================
/// ACTIVITY LOG PROVIDER
/// ===========================================================

@ProviderFor(leadActivityLogs)
final leadActivityLogsProvider = LeadActivityLogsFamily._();

/// ===========================================================
/// ACTIVITY LOG PROVIDER
/// ===========================================================

final class LeadActivityLogsProvider
    extends
        $FunctionalProvider<
          AsyncValue<LeadActivityResponse>,
          LeadActivityResponse,
          FutureOr<LeadActivityResponse>
        >
    with
        $FutureModifier<LeadActivityResponse>,
        $FutureProvider<LeadActivityResponse> {
  /// ===========================================================
  /// ACTIVITY LOG PROVIDER
  /// ===========================================================
  LeadActivityLogsProvider._({
    required LeadActivityLogsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'leadActivityLogsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$leadActivityLogsHash();

  @override
  String toString() {
    return r'leadActivityLogsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<LeadActivityResponse> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<LeadActivityResponse> create(Ref ref) {
    final argument = this.argument as int;
    return leadActivityLogs(ref, leadId: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LeadActivityLogsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$leadActivityLogsHash() => r'25c21b5002346c89fa0dff061b2d4e71c271b6bc';

/// ===========================================================
/// ACTIVITY LOG PROVIDER
/// ===========================================================

final class LeadActivityLogsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<LeadActivityResponse>, int> {
  LeadActivityLogsFamily._()
    : super(
        retry: null,
        name: r'leadActivityLogsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// ===========================================================
  /// ACTIVITY LOG PROVIDER
  /// ===========================================================

  LeadActivityLogsProvider call({required int leadId}) =>
      LeadActivityLogsProvider._(argument: leadId, from: this);

  @override
  String toString() => r'leadActivityLogsProvider';
}

/// ===========================================================
/// REMINDER PROVIDER
/// ===========================================================

@ProviderFor(leadReminders)
final leadRemindersProvider = LeadRemindersFamily._();

/// ===========================================================
/// REMINDER PROVIDER
/// ===========================================================

final class LeadRemindersProvider
    extends
        $FunctionalProvider<
          AsyncValue<LeadReminderResponse>,
          LeadReminderResponse,
          FutureOr<LeadReminderResponse>
        >
    with
        $FutureModifier<LeadReminderResponse>,
        $FutureProvider<LeadReminderResponse> {
  /// ===========================================================
  /// REMINDER PROVIDER
  /// ===========================================================
  LeadRemindersProvider._({
    required LeadRemindersFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'leadRemindersProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$leadRemindersHash();

  @override
  String toString() {
    return r'leadRemindersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<LeadReminderResponse> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<LeadReminderResponse> create(Ref ref) {
    final argument = this.argument as int;
    return leadReminders(ref, leadId: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LeadRemindersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$leadRemindersHash() => r'4349f05e3dd4c2ae4491d56445923ffc4ae91bcc';

/// ===========================================================
/// REMINDER PROVIDER
/// ===========================================================

final class LeadRemindersFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<LeadReminderResponse>, int> {
  LeadRemindersFamily._()
    : super(
        retry: null,
        name: r'leadRemindersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// ===========================================================
  /// REMINDER PROVIDER
  /// ===========================================================

  LeadRemindersProvider call({required int leadId}) =>
      LeadRemindersProvider._(argument: leadId, from: this);

  @override
  String toString() => r'leadRemindersProvider';
}

/// ===========================================================
/// PARTICIPANTS PROVIDER
/// ===========================================================

@ProviderFor(leadParticipants)
final leadParticipantsProvider = LeadParticipantsFamily._();

/// ===========================================================
/// PARTICIPANTS PROVIDER
/// ===========================================================

final class LeadParticipantsProvider
    extends
        $FunctionalProvider<
          AsyncValue<ParticipantsResponse>,
          ParticipantsResponse,
          FutureOr<ParticipantsResponse>
        >
    with
        $FutureModifier<ParticipantsResponse>,
        $FutureProvider<ParticipantsResponse> {
  /// ===========================================================
  /// PARTICIPANTS PROVIDER
  /// ===========================================================
  LeadParticipantsProvider._({
    required LeadParticipantsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'leadParticipantsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$leadParticipantsHash();

  @override
  String toString() {
    return r'leadParticipantsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ParticipantsResponse> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ParticipantsResponse> create(Ref ref) {
    final argument = this.argument as int;
    return leadParticipants(ref, leadId: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LeadParticipantsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$leadParticipantsHash() => r'65c92430b9a29d5b886581fca5a8d032ea61afcc';

/// ===========================================================
/// PARTICIPANTS PROVIDER
/// ===========================================================

final class LeadParticipantsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ParticipantsResponse>, int> {
  LeadParticipantsFamily._()
    : super(
        retry: null,
        name: r'leadParticipantsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// ===========================================================
  /// PARTICIPANTS PROVIDER
  /// ===========================================================

  LeadParticipantsProvider call({required int leadId}) =>
      LeadParticipantsProvider._(argument: leadId, from: this);

  @override
  String toString() => r'leadParticipantsProvider';
}

@ProviderFor(editLeadFormConfig)
final editLeadFormConfigProvider = EditLeadFormConfigFamily._();

final class EditLeadFormConfigProvider
    extends
        $FunctionalProvider<
          AsyncValue<LeadFormConfigResponse>,
          LeadFormConfigResponse,
          FutureOr<LeadFormConfigResponse>
        >
    with
        $FutureModifier<LeadFormConfigResponse>,
        $FutureProvider<LeadFormConfigResponse> {
  EditLeadFormConfigProvider._({
    required EditLeadFormConfigFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'editLeadFormConfigProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$editLeadFormConfigHash();

  @override
  String toString() {
    return r'editLeadFormConfigProvider'
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
    return editLeadFormConfig(ref, leadId: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is EditLeadFormConfigProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$editLeadFormConfigHash() =>
    r'cdc783c4eace56fb0632d23e71f696ac8b2123e5';

final class EditLeadFormConfigFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<LeadFormConfigResponse>, int> {
  EditLeadFormConfigFamily._()
    : super(
        retry: null,
        name: r'editLeadFormConfigProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EditLeadFormConfigProvider call({required int leadId}) =>
      EditLeadFormConfigProvider._(argument: leadId, from: this);

  @override
  String toString() => r'editLeadFormConfigProvider';
}

@ProviderFor(searchLeads)
final searchLeadsProvider = SearchLeadsFamily._();

final class SearchLeadsProvider
    extends
        $FunctionalProvider<
          AsyncValue<LeadsResponse>,
          LeadsResponse,
          FutureOr<LeadsResponse>
        >
    with $FutureModifier<LeadsResponse>, $FutureProvider<LeadsResponse> {
  SearchLeadsProvider._({
    required SearchLeadsFamily super.from,
    required ({String search, int perPage, int page}) super.argument,
  }) : super(
         retry: null,
         name: r'searchLeadsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$searchLeadsHash();

  @override
  String toString() {
    return r'searchLeadsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<LeadsResponse> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<LeadsResponse> create(Ref ref) {
    final argument = this.argument as ({String search, int perPage, int page});
    return searchLeads(
      ref,
      search: argument.search,
      perPage: argument.perPage,
      page: argument.page,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SearchLeadsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$searchLeadsHash() => r'f47bdf31fce3273008448ed490b6e166e4b512fe';

final class SearchLeadsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<LeadsResponse>,
          ({String search, int perPage, int page})
        > {
  SearchLeadsFamily._()
    : super(
        retry: null,
        name: r'searchLeadsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SearchLeadsProvider call({
    required String search,
    int perPage = 20,
    int page = 1,
  }) => SearchLeadsProvider._(
    argument: (search: search, perPage: perPage, page: page),
    from: this,
  );

  @override
  String toString() => r'searchLeadsProvider';
}
