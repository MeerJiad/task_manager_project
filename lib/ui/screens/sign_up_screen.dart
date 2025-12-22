import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_project/data/services/network_caller.dart';
import 'package:task_manager_project/ui/screens/sign_in_screen.dart';
import 'package:task_manager_project/ui/utils/snack_bar.dart';
import 'package:task_manager_project/ui/utils/validators.dart';
import 'package:task_manager_project/ui/widgets/background_screen_widget.dart';
import 'package:task_manager_project/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager_project/ui/widgets/pass_text_form_field_widget.dart';
import 'package:task_manager_project/ui/widgets/sign_in_and_sign_up_rich_text_widget.dart';

import '../utils/api_urls.dart';

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
  bool _showLoader = false;

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
                height: 60,
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
                validator: (value) {
                  return textFormFieldDefaultValidation(
                      value, 'Enter your email');
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _firstNameTEC,
                decoration: const InputDecoration(hintText: 'First Name'),
                keyboardType: TextInputType.name,
                validator: (value) => textFormFieldDefaultValidation(
                    value, 'Enter your first name'),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _lastNameTEC,
                decoration: const InputDecoration(hintText: 'Last Name'),
                keyboardType: TextInputType.name,
                validator: (value) => textFormFieldDefaultValidation(
                    value, 'Enter your last name'),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _mobileTEC,
                decoration: const InputDecoration(hintText: 'Mobile'),
                keyboardType: TextInputType.number,
                validator: (value) => textFormFieldDefaultValidation(
                    value, 'Enter your phone number'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
              Align(
                alignment: Alignment.bottomCenter,
                child: Visibility(
                  visible: _showLoader == false,
                  replacement: const CenteredCircularProgressIndicator(),
                  child: ElevatedButton(
                    onPressed: () {
                      _buildSignUpButtonOnTap();
                    },
                    child: const Icon(CupertinoIcons.arrow_right_circle),
                  ),
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

  void _buildSignUpButtonOnTap() {
    //we don't wanna keep the code of api calling in the ui code ,that's why we have did method extraction manually.
    if (_formKey.currentState!.validate()) {
      _signUp();
    }
  }

  Future<void> _signUp() async {
    setState(() {
      _showLoader = true;
    });
    Map<String, String> registrationPostRequestBody = {
      "email": _emailTEC.text.trim(),
      "firstName": _firstNameTEC.text.trim(),
      "lastName": _lastNameTEC.text.trim(),
      "mobile": _mobileTEC.text.trim(),
      "password": _passTEC.text,
      //we will not trim pass because some user can give space here.
      "photo": "",
    };
    NetworkResponse response = await NetworkCaller.postRequest(
        url: ApiUrls.registrationUrl, body: registrationPostRequestBody);
    setState(() {
      _showLoader = false;
    });
    if (response.isSuccess) {
      Navigator.pushReplacementNamed(context, SignInScreen.name);
      snackBar(context: context, text: "Account Created Successfully");
    } else {
      snackBar(context: context, text: response.errorMessage);
    }
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
