import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sale_pipeline_business/features/auth/presentations/choose_task_page.dart';
import 'package:sale_pipeline_business/utils/extensions.dart';
import 'package:sale_pipeline_business/utils/images.dart';

import '../../../common_widgets/common_button.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/secure_storage.dart';
import '../../../utils/strings.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(color: Color(0xFF061B10)),
        child: Stack(
          children: [
            /// background image
            Positioned.fill(
              child: Image.asset(kBgPatternImage, fit: BoxFit.cover),
            ),

            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 24,
                ),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
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

                    const SizedBox(height: 30),

                    /// center image
                    SizedBox(
                      width: 240,
                      height: 220,
                      child: Image.asset(
                        kLoginIllustrationImage,
                        fit: BoxFit.contain,
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// username
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Username',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ),

                    const SizedBox(height: 8),

                    _InputField(hint: 'Enter Full Name'),

                    const SizedBox(height: 20),

                    /// password
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Password',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ),

                    const SizedBox(height: 8),

                    _InputField(hint: 'Enter Password', obscureText: true),

                    const Spacer(),

                    /// login button
                    CommonButton(
                      text: 'Login',
                      color: kPrimaryColor,
                      onTap: () async{
                        await ref.read(secureStorageProvider).saveAuthStatus(kAuthLoggedIn);
                        ref.invalidate(secureStorageProvider);
                      },
                    ),

                    const SizedBox(height: 10),
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

///input field
class _InputField extends StatefulWidget {
  final String hint;
  final bool obscureText;

  const _InputField({
    super.key,
    required this.hint,
    this.obscureText = false,
  });

  @override
  State<_InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<_InputField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: const TextStyle(color: Colors.white38),
        filled: true,
        fillColor: Colors.green.withOpacity(0.15),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),

        /// eye icon
        suffixIcon: widget.obscureText
            ? IconButton(
          onPressed: () {
            setState(() {
              _obscure = !_obscure;
            });
          },
          icon: Icon(
            _obscure
                ? Icons.visibility_off_rounded
                : Icons.visibility_rounded,
            color: Colors.white54,
          ),
        )
            : null,

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: Colors.green.withOpacity(0.25),
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: Color(0xFF00C853),
            width: 1.4,
          ),
        ),
      ),
    );
  }
}