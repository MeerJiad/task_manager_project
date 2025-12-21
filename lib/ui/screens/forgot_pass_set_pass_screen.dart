import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_project/ui/widgets/back_to_sign_in_button_widget.dart';
import 'package:task_manager_project/ui/widgets/background_screen_widget.dart';
import 'package:task_manager_project/ui/widgets/pass_text_form_field_widget.dart';

class ForgotPassSetPassScreen extends StatefulWidget {
  const ForgotPassSetPassScreen({super.key});

  static const String name = '/forgot_pass/reset_pass';

  @override
  State<ForgotPassSetPassScreen> createState() =>
      _ForgotPassSetPassScreenState();
}

class _ForgotPassSetPassScreenState extends State<ForgotPassSetPassScreen> {
  final TextEditingController _newPassTEC = TextEditingController();
  final TextEditingController _confirmNewPassTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return BackgroundScreen(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 160,
                  ),
                  Text(
                    'Set Password',
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Password must be at least 8 characters and include a combination of letters and numbers',
                    style: textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                 PassTFFWidget(controller: _newPassTEC, hintText: 'New Password'),
                  const SizedBox(
                    height: 20,
                  ),
                  PassTFFWidget(controller: _confirmNewPassTEC, hintText: 'Confirm New Password'),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Icon(CupertinoIcons.arrow_right_circle),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const BackToSignInButton(),
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
    _newPassTEC.dispose();
    _confirmNewPassTEC.dispose();
  }
}
