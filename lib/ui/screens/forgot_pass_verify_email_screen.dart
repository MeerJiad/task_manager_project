import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_project/ui/screens/forgot_pass_verify_pin_screen.dart';
import 'package:task_manager_project/ui/widgets/background_screen_widget.dart';
import '../widgets/back_to_sign_in_button_widget.dart';

class ForgotPassEmailVerifyScreen extends StatefulWidget {
  const ForgotPassEmailVerifyScreen({super.key});

  static const String name = '/forgot_pass/email_verify';

  @override
  State<ForgotPassEmailVerifyScreen> createState() =>
      _ForgotPassEmailVerifyScreenState();
}

class _ForgotPassEmailVerifyScreenState
    extends State<ForgotPassEmailVerifyScreen> {
  final TextEditingController _emailTEC = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
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
                  'Your Email  Address',
                  style: textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'A 6 digit verification pin will send to your email address',
                  style: textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _emailTEC,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(hintText: 'Email'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, ForgotPassVerifyPinScreen.name);
                  },
                  child: const Icon(CupertinoIcons.arrow_right_circle),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: BackToSignInButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailTEC.dispose();
  }
}
