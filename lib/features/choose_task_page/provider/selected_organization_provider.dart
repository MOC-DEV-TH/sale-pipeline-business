import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/organizations_response.dart';

part 'selected_organization_provider.g.dart';

@Riverpod(keepAlive: true)
class SelectedOrganization extends _$SelectedOrganization {
  @override
  OrganizationVO? build() {
    return null;
  }

  void setOrganization(
      OrganizationVO organization,
      ) {
    state = organization;
  }

  void clear() {
    state = null;
  }
}