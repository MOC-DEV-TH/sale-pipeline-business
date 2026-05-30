import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:sale_pipeline_business/features/auth/presentations/choose_task_page.dart';
import 'package:sale_pipeline_business/utils/async_value_ui.dart';
import 'package:sale_pipeline_business/utils/extensions.dart';
import 'package:sale_pipeline_business/utils/images.dart';

import '../../../common_widgets/common_button.dart';
import '../../../common_widgets/loading_view.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/secure_storage.dart';
import '../../../utils/strings.dart';
import '../controller/auth_controller.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {

  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    ref.listen<AsyncValue>(
      authControllerProvider,
          (_, next) => next.showAlertDialogOnError(context),
    );

    final ctrlState = ref.watch(authControllerProvider);

    return Scaffold(
      body: Stack(
        children: [
          Container(
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

                        _InputField(hint: 'Enter Full Name',controller: _userNameController,),

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

                        _InputField(hint: 'Enter Password', obscureText: true,controller: _passwordController,),

                        const Spacer(),

                        /// login button
                        CommonButton(
                          text: 'Login',
                          color: kPrimaryColor,
                          onTap: _onLogin,
                        ),

                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// Loading overlay
          if (ctrlState.isLoading)
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
    );
  }

  ///on press login
  void _onLogin() async {
    await ref.read(secureStorageProvider).saveAuthStatus(kAuthLoggedIn);
    ref.invalidate(secureStorageProvider);
    // final userId = _userNameController.text.trim();
    // final password = _passwordController.text;
    //
    // final state = ref.read(authControllerProvider);
    // if (state.isLoading) return;
    //
    // final ok = await ref
    //     .read(authControllerProvider.notifier)
    //     .login(userId: userId, password: password);
    //
    // if (ok && mounted) {
    //   await ref.read(secureStorageProvider).saveAuthStatus(kAuthLoggedIn);
    //   ref.invalidate(secureStorageProvider);
    // }
  }
}


///input field
class _InputField extends StatefulWidget {
  final String hint;
  final bool obscureText;
  final TextEditingController controller;

  const _InputField({
    super.key,
    required this.hint,
    required this.controller,
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
      controller: widget.controller,
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