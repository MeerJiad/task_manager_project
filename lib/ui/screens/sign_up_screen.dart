import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_project/ui/widgets/background_screen_widget.dart';
import 'package:task_manager_project/ui/widgets/pass_text_form_field_widget.dart';
import 'package:task_manager_project/ui/widgets/sign_in_and_sign_up_rich_text_widget.dart';

import '../utils/app_colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String name = '/sign_up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailTEC = TextEditingController();
  final TextEditingController _firstNameTEC = TextEditingController();
  final TextEditingController _lastNameTEC = TextEditingController();
  final TextEditingController _mobileTEC = TextEditingController();
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
                height: 100,
              ),
              Text(
                'Join With Us',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 32,
              ),
              TextFormField(
                controller: _emailTEC,
                decoration: const InputDecoration(hintText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _firstNameTEC,
                decoration: const InputDecoration(hintText: 'First Name'),
                keyboardType: TextInputType.name,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _lastNameTEC,
                decoration: const InputDecoration(hintText: 'Last Name'),
                keyboardType: TextInputType.name,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _mobileTEC,
                decoration: const InputDecoration(hintText: 'Mobile'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 20,
              ),
              PassTFFWidget(controller: _passTEC, hintText: 'Password'),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Icon(CupertinoIcons.arrow_right_circle),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: SignInAndSignUpRichTextWidget(
                      firstTextSpanText: 'Have an account?',
                      secondTextSpanText: ' Sign in',
                      tapGestureRecognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pop(context);
                        }))
            ],
          ),
        ),
      ),
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _emailTEC.dispose();
    _firstNameTEC.dispose();
    _lastNameTEC.dispose();
    _mobileTEC.dispose();
    _passTEC.dispose();
  }
}
