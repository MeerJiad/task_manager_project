import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_project/ui/screens/forgot_pass_verify_email_screen.dart';
import 'package:task_manager_project/ui/screens/sign_up_screen.dart';
import 'package:task_manager_project/ui/widgets/background_screen_widget.dart';
import 'package:task_manager_project/ui/widgets/pass_TFF_widget.dart';
import '../utils/app_colors.dart';
import 'main_bottom_nav_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String name = '/sign_in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailTEC = TextEditingController();
  final TextEditingController _passTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 160,
                ),
                Text(
                  'Get Started With',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 32,
                ),
                TextFormField(
                  controller: _emailTEC,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(hintText: 'Email'),
                ),
                const SizedBox(
                  height: 20,
                ),
                PassTFFWidget(
                  controller: _passTEC,
                  hintText: 'Password',
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, MainBottomNavScreen.name);
                  },
                  child: const Icon(CupertinoIcons.arrow_right_circle),
                ),
                const SizedBox(
                  height: 70,
                ),
                Center(
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, ForgotPassEmailVerifyScreen.name);
                        },
                        child: const Text('Forgot Password?'),
                      ),
                      _buildRichText(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRichText() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontWeight: FontWeight.w500),
        children: [
          const TextSpan(
              text: "Don't have an account?",
              style: TextStyle(
                color: Colors.black,
              )),
          TextSpan(
              text: " Sign up",
              style: const TextStyle(
                color: AppColors.themeColor,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, SignUpScreen.name);
                })
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailTEC.dispose();
    _passTEC.dispose();
  }
}
