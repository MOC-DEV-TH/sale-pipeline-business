import 'package:flutter/material.dart';

import '../../../../utils/images.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 8),
      child: Row(
        children: [
          InkWell(
            onTap: onBack,
            borderRadius: BorderRadius.circular(50),
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF0B341F),
                border: Border.all(color: const Color(0xFF397457)),
              ),
              child: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),

          const Spacer(),

          /// Logo
          Image.asset(kLogoImage, width: 160, height: 40, fit: BoxFit.contain),

          const Spacer(),

          /// balance left back button width
          const SizedBox(width: 58),
        ],
      ),
    );
  }
}