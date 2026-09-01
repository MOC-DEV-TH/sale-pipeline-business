import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sale_pipeline_business/features/dashboard/presentation/dashboard_page.dart';
import 'package:sale_pipeline_business/routing/go_router/go_router_delegate.dart';
import 'package:sale_pipeline_business/utils/app_colors.dart';
import 'package:sale_pipeline_business/utils/extensions.dart';
import 'package:sale_pipeline_business/utils/images.dart';

import '../../../common_widgets/common_button.dart';

class ChooseTaskPage extends StatelessWidget {
  const ChooseTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFF061B10),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                kBgPatternImage,
                fit: BoxFit.cover,
              ),
            ),

            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(28, 42, 28, 34),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome to',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 24,
                          ),
                        ),
                        Image.asset(
                          kLogoImage,
                          width: 270,
                          height: 66,
                        ),

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

                    /// center image
                    SizedBox(
                      width: 290,
                      height: 290,
                      child: Image.asset(
                        kTargetImage,
                        fit: BoxFit.contain,
                      ),
                    ),

                     Spacer(),

                    const Text(
                      'Choose your task!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                      ),
                    ),

                    const SizedBox(height: 26),

                    CommonButton(
                      text: 'Add New Lead',
                      color: kPrimaryColor,
                      onTap: () {
                        context.go(RoutePath.newLeadStep.path);
                      },
                    ),

                    const SizedBox(height: 16),

                    CommonButton(
                      text: 'Go to Dashboard',
                      color: kSecondaryColor,
                      onTap: () {
                        context.go('/');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
