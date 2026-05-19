import 'package:flutter/material.dart';
import 'package:sale_pipeline_business/utils/app_colors.dart';

import '../../../utils/images.dart';
import 'base_widgets.dart';

class SuccessStepPage extends StatelessWidget {
  final VoidCallback onAddNewLead;
  final VoidCallback onGoDashboard;

  const SuccessStepPage({
    required this.onAddNewLead,
    required this.onGoDashboard,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),

        SizedBox(
          child: Image.asset(
            kSuccessIllustrationImage,
            fit: BoxFit.contain,
          ),
        ),

        const SizedBox(height: 24),

        const Text(
          'Success!',
          style: TextStyle(
            color: Color(0xFF00C853),
            fontSize: 48,
            fontWeight: FontWeight.w900,
          ),
        ),

        const SizedBox(height: 8),

        const Text(
          'Your action has been\ncompleted successfully',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),

        const Spacer(),

        StepButton(
          text: 'Add New Lead',
          color: kPrimaryColor,
          onTap: onAddNewLead,
          height: 56,
          textSize:18,
        ),

        const SizedBox(height: 14),

        StepButton(
          text: 'Go to Dashboard',
          color: kSecondaryColor,
          onTap: onGoDashboard,
          height: 56,
          textSize: 18,
        ),
      ],
    );
  }
}