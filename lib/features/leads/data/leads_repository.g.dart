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
String _$fetchLeadDetailHash() => r'bb170f00e396efbc161bee389002567b8ebfb3c5';

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
class FetchLeadDetailFamily extends Family<AsyncValue<LeadDetailsResponse>> {
  /// See also [fetchLeadDetail].
  const FetchLeadDetailFamily();

  /// See also [fetchLeadDetail].
  FetchLeadDetailProvider call({required int leadId}) {
    return FetchLeadDetailProvider(leadId: leadId);
  }

  @override
  FetchLeadDetailProvider getProviderOverride(
    covariant FetchLeadDetailProvider provider,
  ) {
    return call(leadId: provider.leadId);
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
    extends AutoDisposeFutureProvider<LeadDetailsResponse> {
  /// See also [fetchLeadDetail].
  FetchLeadDetailProvider({required int leadId})
    : this._internal(
        (ref) => fetchLeadDetail(ref as FetchLeadDetailRef, leadId: leadId),
        from: fetchLeadDetailProvider,
        name: r'fetchLeadDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$fetchLeadDetailHash,
        dependencies: FetchLeadDetailFamily._dependencies,
        allTransitiveDependencies:
            FetchLeadDetailFamily._allTransitiveDependencies,
        leadId: leadId,
      );

  FetchLeadDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.leadId,
  }) : super.internal();

  final int leadId;

  @override
  Override overrideWith(
    FutureOr<LeadDetailsResponse> Function(FetchLeadDetailRef provider) create,
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
        leadId: leadId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<LeadDetailsResponse> createElement() {
    return _FetchLeadDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchLeadDetailProvider && other.leadId == leadId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, leadId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FetchLeadDetailRef on AutoDisposeFutureProviderRef<LeadDetailsResponse> {
  /// The parameter `leadId` of this provider.
  int get leadId;
}

class _FetchLeadDetailProviderElement
    extends AutoDisposeFutureProviderElement<LeadDetailsResponse>
    with FetchLeadDetailRef {
  _FetchLeadDetailProviderElement(super.provider);

  @override
  int get leadId => (origin as FetchLeadDetailProvider).leadId;
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

String _$leadActivityLogsHash() => r'b8b80671287c6d429b874f319622331d6066f8f9';

/// ===========================================================
/// ACTIVITY LOG PROVIDER
/// ===========================================================
///
/// Copied from [leadActivityLogs].
@ProviderFor(leadActivityLogs)
const leadActivityLogsProvider = LeadActivityLogsFamily();

/// ===========================================================
/// ACTIVITY LOG PROVIDER
/// ===========================================================
///
/// Copied from [leadActivityLogs].
class LeadActivityLogsFamily extends Family<AsyncValue<LeadActivityResponse>> {
  /// ===========================================================
  /// ACTIVITY LOG PROVIDER
  /// ===========================================================
  ///
  /// Copied from [leadActivityLogs].
  const LeadActivityLogsFamily();

  /// ===========================================================
  /// ACTIVITY LOG PROVIDER
  /// ===========================================================
  ///
  /// Copied from [leadActivityLogs].
  LeadActivityLogsProvider call({required int leadId}) {
    return LeadActivityLogsProvider(leadId: leadId);
  }

  @override
  LeadActivityLogsProvider getProviderOverride(
    covariant LeadActivityLogsProvider provider,
  ) {
    return call(leadId: provider.leadId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'leadActivityLogsProvider';
}

/// ===========================================================
/// ACTIVITY LOG PROVIDER
/// ===========================================================
///
/// Copied from [leadActivityLogs].
class LeadActivityLogsProvider
    extends AutoDisposeFutureProvider<LeadActivityResponse> {
  /// ===========================================================
  /// ACTIVITY LOG PROVIDER
  /// ===========================================================
  ///
  /// Copied from [leadActivityLogs].
  LeadActivityLogsProvider({required int leadId})
    : this._internal(
        (ref) => leadActivityLogs(ref as LeadActivityLogsRef, leadId: leadId),
        from: leadActivityLogsProvider,
        name: r'leadActivityLogsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$leadActivityLogsHash,
        dependencies: LeadActivityLogsFamily._dependencies,
        allTransitiveDependencies:
            LeadActivityLogsFamily._allTransitiveDependencies,
        leadId: leadId,
      );

  LeadActivityLogsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.leadId,
  }) : super.internal();

  final int leadId;

  @override
  Override overrideWith(
    FutureOr<LeadActivityResponse> Function(LeadActivityLogsRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LeadActivityLogsProvider._internal(
        (ref) => create(ref as LeadActivityLogsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        leadId: leadId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<LeadActivityResponse> createElement() {
    return _LeadActivityLogsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LeadActivityLogsProvider && other.leadId == leadId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, leadId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LeadActivityLogsRef
    on AutoDisposeFutureProviderRef<LeadActivityResponse> {
  /// The parameter `leadId` of this provider.
  int get leadId;
}

class _LeadActivityLogsProviderElement
    extends AutoDisposeFutureProviderElement<LeadActivityResponse>
    with LeadActivityLogsRef {
  _LeadActivityLogsProviderElement(super.provider);

  @override
  int get leadId => (origin as LeadActivityLogsProvider).leadId;
}

String _$leadRemindersHash() => r'170cc53874182822ddc62411a51b586eca9a9446';

/// ===========================================================
/// REMINDER PROVIDER
/// ===========================================================
///
/// Copied from [leadReminders].
@ProviderFor(leadReminders)
const leadRemindersProvider = LeadRemindersFamily();

/// ===========================================================
/// REMINDER PROVIDER
/// ===========================================================
///
/// Copied from [leadReminders].
class LeadRemindersFamily extends Family<AsyncValue<LeadReminderResponse>> {
  /// ===========================================================
  /// REMINDER PROVIDER
  /// ===========================================================
  ///
  /// Copied from [leadReminders].
  const LeadRemindersFamily();

  /// ===========================================================
  /// REMINDER PROVIDER
  /// ===========================================================
  ///
  /// Copied from [leadReminders].
  LeadRemindersProvider call({required int leadId}) {
    return LeadRemindersProvider(leadId: leadId);
  }

  @override
  LeadRemindersProvider getProviderOverride(
    covariant LeadRemindersProvider provider,
  ) {
    return call(leadId: provider.leadId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'leadRemindersProvider';
}

/// ===========================================================
/// REMINDER PROVIDER
/// ===========================================================
///
/// Copied from [leadReminders].
class LeadRemindersProvider
    extends AutoDisposeFutureProvider<LeadReminderResponse> {
  /// ===========================================================
  /// REMINDER PROVIDER
  /// ===========================================================
  ///
  /// Copied from [leadReminders].
  LeadRemindersProvider({required int leadId})
    : this._internal(
        (ref) => leadReminders(ref as LeadRemindersRef, leadId: leadId),
        from: leadRemindersProvider,
        name: r'leadRemindersProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$leadRemindersHash,
        dependencies: LeadRemindersFamily._dependencies,
        allTransitiveDependencies:
            LeadRemindersFamily._allTransitiveDependencies,
        leadId: leadId,
      );

  LeadRemindersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.leadId,
  }) : super.internal();

  final int leadId;

  @override
  Override overrideWith(
    FutureOr<LeadReminderResponse> Function(LeadRemindersRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LeadRemindersProvider._internal(
        (ref) => create(ref as LeadRemindersRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        leadId: leadId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<LeadReminderResponse> createElement() {
    return _LeadRemindersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LeadRemindersProvider && other.leadId == leadId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, leadId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LeadRemindersRef on AutoDisposeFutureProviderRef<LeadReminderResponse> {
  /// The parameter `leadId` of this provider.
  int get leadId;
}

class _LeadRemindersProviderElement
    extends AutoDisposeFutureProviderElement<LeadReminderResponse>
    with LeadRemindersRef {
  _LeadRemindersProviderElement(super.provider);

  @override
  int get leadId => (origin as LeadRemindersProvider).leadId;
}

String _$leadParticipantsHash() => r'310e0141186c072e266f16f70553cec56d97d972';

/// ===========================================================
/// PARTICIPANTS PROVIDER
/// ===========================================================
///
/// Copied from [leadParticipants].
@ProviderFor(leadParticipants)
const leadParticipantsProvider = LeadParticipantsFamily();

/// ===========================================================
/// PARTICIPANTS PROVIDER
/// ===========================================================
///
/// Copied from [leadParticipants].
class LeadParticipantsFamily extends Family<AsyncValue<ParticipantsResponse>> {
  /// ===========================================================
  /// PARTICIPANTS PROVIDER
  /// ===========================================================
  ///
  /// Copied from [leadParticipants].
  const LeadParticipantsFamily();

  /// ===========================================================
  /// PARTICIPANTS PROVIDER
  /// ===========================================================
  ///
  /// Copied from [leadParticipants].
  LeadParticipantsProvider call({required int leadId}) {
    return LeadParticipantsProvider(leadId: leadId);
  }

  @override
  LeadParticipantsProvider getProviderOverride(
    covariant LeadParticipantsProvider provider,
  ) {
    return call(leadId: provider.leadId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'leadParticipantsProvider';
}

/// ===========================================================
/// PARTICIPANTS PROVIDER
/// ===========================================================
///
/// Copied from [leadParticipants].
class LeadParticipantsProvider
    extends AutoDisposeFutureProvider<ParticipantsResponse> {
  /// ===========================================================
  /// PARTICIPANTS PROVIDER
  /// ===========================================================
  ///
  /// Copied from [leadParticipants].
  LeadParticipantsProvider({required int leadId})
    : this._internal(
        (ref) => leadParticipants(ref as LeadParticipantsRef, leadId: leadId),
        from: leadParticipantsProvider,
        name: r'leadParticipantsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$leadParticipantsHash,
        dependencies: LeadParticipantsFamily._dependencies,
        allTransitiveDependencies:
            LeadParticipantsFamily._allTransitiveDependencies,
        leadId: leadId,
      );

  LeadParticipantsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.leadId,
  }) : super.internal();

  final int leadId;

  @override
  Override overrideWith(
    FutureOr<ParticipantsResponse> Function(LeadParticipantsRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LeadParticipantsProvider._internal(
        (ref) => create(ref as LeadParticipantsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        leadId: leadId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ParticipantsResponse> createElement() {
    return _LeadParticipantsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LeadParticipantsProvider && other.leadId == leadId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, leadId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LeadParticipantsRef
    on AutoDisposeFutureProviderRef<ParticipantsResponse> {
  /// The parameter `leadId` of this provider.
  int get leadId;
}

class _LeadParticipantsProviderElement
    extends AutoDisposeFutureProviderElement<ParticipantsResponse>
    with LeadParticipantsRef {
  _LeadParticipantsProviderElement(super.provider);

  @override
  int get leadId => (origin as LeadParticipantsProvider).leadId;
}

String _$editLeadFormConfigHash() =>
    r'2608542c532268b0b89bf54127a606a330c05af7';

/// See also [editLeadFormConfig].
@ProviderFor(editLeadFormConfig)
const editLeadFormConfigProvider = EditLeadFormConfigFamily();

/// See also [editLeadFormConfig].
class EditLeadFormConfigFamily
    extends Family<AsyncValue<LeadFormConfigResponse>> {
  /// See also [editLeadFormConfig].
  const EditLeadFormConfigFamily();

  /// See also [editLeadFormConfig].
  EditLeadFormConfigProvider call({required int leadId}) {
    return EditLeadFormConfigProvider(leadId: leadId);
  }

  @override
  EditLeadFormConfigProvider getProviderOverride(
    covariant EditLeadFormConfigProvider provider,
  ) {
    return call(leadId: provider.leadId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'editLeadFormConfigProvider';
}

/// See also [editLeadFormConfig].
class EditLeadFormConfigProvider
    extends AutoDisposeFutureProvider<LeadFormConfigResponse> {
  /// See also [editLeadFormConfig].
  EditLeadFormConfigProvider({required int leadId})
    : this._internal(
        (ref) =>
            editLeadFormConfig(ref as EditLeadFormConfigRef, leadId: leadId),
        from: editLeadFormConfigProvider,
        name: r'editLeadFormConfigProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$editLeadFormConfigHash,
        dependencies: EditLeadFormConfigFamily._dependencies,
        allTransitiveDependencies:
            EditLeadFormConfigFamily._allTransitiveDependencies,
        leadId: leadId,
      );

  EditLeadFormConfigProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.leadId,
  }) : super.internal();

  final int leadId;

  @override
  Override overrideWith(
    FutureOr<LeadFormConfigResponse> Function(EditLeadFormConfigRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EditLeadFormConfigProvider._internal(
        (ref) => create(ref as EditLeadFormConfigRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        leadId: leadId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<LeadFormConfigResponse> createElement() {
    return _EditLeadFormConfigProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EditLeadFormConfigProvider && other.leadId == leadId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, leadId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EditLeadFormConfigRef
    on AutoDisposeFutureProviderRef<LeadFormConfigResponse> {
  /// The parameter `leadId` of this provider.
  int get leadId;
}

class _EditLeadFormConfigProviderElement
    extends AutoDisposeFutureProviderElement<LeadFormConfigResponse>
    with EditLeadFormConfigRef {
  _EditLeadFormConfigProviderElement(super.provider);

  @override
  int get leadId => (origin as EditLeadFormConfigProvider).leadId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
