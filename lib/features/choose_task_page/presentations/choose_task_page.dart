import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:sale_pipeline_business/features/choose_task_page/data/choose_task_repository.dart';
import 'package:sale_pipeline_business/features/choose_task_page/model/organizations_response.dart';
import 'package:sale_pipeline_business/routing/go_router/go_router_delegate.dart';
import 'package:sale_pipeline_business/utils/app_colors.dart';
import 'package:sale_pipeline_business/utils/images.dart';

import '../../../common_widgets/common_button.dart';
import '../../../common_widgets/loading_view.dart';
import '../provider/selected_organization_provider.dart';

class ChooseTaskPage extends ConsumerStatefulWidget {
  const ChooseTaskPage({super.key});

  @override
  ConsumerState<ChooseTaskPage> createState() => _ChooseTaskPageState();
}

class _ChooseTaskPageState extends ConsumerState<ChooseTaskPage> {
  OrganizationVO? _selectedOrganization;

  @override
  Widget build(BuildContext context) {
    final organizationState = ref.watch(fetchOrganizationListProvider);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFF061B10),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(kBgPatternImage, fit: BoxFit.cover),
            ),

            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(28, 42, 28, 34),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Welcome to',
                          style: TextStyle(color: Colors.white70, fontSize: 24),
                        ),
                        Image.asset(kLogoImage, width: 270, height: 66),
                      ],
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      'Manage your customers\nand stay on top of your workflow',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 50),

                    SizedBox(
                      width: 290,
                      height: 290,
                      child: Image.asset(kTargetImage, fit: BoxFit.contain),
                    ),

                    const Spacer(),

                    const Text(
                      'Choose your task!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                      ),
                    ),

                    const SizedBox(height: 18),

                    /// Organization Dropdown
                    organizationState.when(
                      data: (response) {
                        final organizations =
                            response.data?.organizations ?? [];

                        if (organizations.isEmpty) {
                          return const Text(
                            'No organizations available',
                            style: TextStyle(color: Colors.white70),
                          );
                        }

                        return _OrganizationDropdown(
                          organizations: organizations,
                          selectedOrganization: _selectedOrganization,
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }

                            setState(() {
                              _selectedOrganization = value;
                            });

                            ref
                                .read(
                              selectedOrganizationProvider.notifier,
                            )
                                .setOrganization(value);

                            final selected = ref.read(
                              selectedOrganizationProvider,
                            );

                            debugPrint(
                              'Selected Organization >>> '
                                  '${selected?.id} - ${selected?.name}',
                            );
                          },
                        );
                      },

                      loading: () => const SizedBox(
                        height: 56,
                        child: Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                      ),

                      error: (error, stack) => Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.redAccent),
                        ),
                        child: Text(
                          error.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    CommonButton(
                      text: 'Add New Lead',
                      color: kPrimaryColor,
                      onTap: () {
                        if (_selectedOrganization == null) {
                          _showOrganizationRequired(context);

                          return;
                        }

                        context.go(
                          RoutePath.newLeadStep.path,
                        );
                      },
                    ),

                    const SizedBox(height: 16),

                    CommonButton(
                      text: 'Go to Dashboard',
                      color: kSecondaryColor,
                      onTap: () {
                        if (_selectedOrganization == null) {
                          _showOrganizationRequired(context);

                          return;
                        }

                        ///dashboard
                        context.go(
                          '/',
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            /// Loading overlay
            if (organizationState.isLoading)
              Container(
                color: Colors.black12,
                child: const Center(
                  child: LoadingView(
                    indicatorColor: Colors.white,
                    indicator: Indicator.ballRotate,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showOrganizationRequired(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          duration: Duration(milliseconds: 1000),
          content: Text(
            'Please choose an organization',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
  }
}

class _OrganizationDropdown extends StatelessWidget {
  const _OrganizationDropdown({
    required this.organizations,
    required this.selectedOrganization,
    required this.onChanged,
  });

  final List<OrganizationVO> organizations;
  final OrganizationVO? selectedOrganization;
  final ValueChanged<OrganizationVO?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 58,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: const Color(0xFF0B2A19),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.18), width: 1.2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<OrganizationVO>(
          value: selectedOrganization,
          isExpanded: true,
          dropdownColor: const Color(0xFF0B2A19),

          hint: const Text(
            'Choose organization',
            style: TextStyle(color: Colors.white60, fontSize: 15),
          ),

          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.white70,
            size: 28,
          ),

          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),

          items: organizations.map((organization) {
            return DropdownMenuItem<OrganizationVO>(
              value: organization,
              child: Row(
                children: [
                  const Icon(
                    Icons.business_rounded,
                    color: kPrimaryColor,
                    size: 21,
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      organization.name ?? 'Organization',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),

          onChanged: onChanged,
        ),
      ),
    );
  }
}
