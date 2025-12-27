import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_project/data/models/user_model.dart';
import 'package:task_manager_project/data/services/network_caller.dart';
import 'package:task_manager_project/ui/controllers/auth_controllers.dart';
import 'package:task_manager_project/ui/screens/forgot_pass_verify_email_screen.dart';
import 'package:task_manager_project/ui/screens/sign_up_screen.dart';
import 'package:task_manager_project/ui/utils/api_urls.dart';
import 'package:task_manager_project/ui/utils/snack_bar.dart';
import 'package:task_manager_project/ui/utils/validators.dart';
import 'package:task_manager_project/ui/widgets/background_screen_widget.dart';
import 'package:task_manager_project/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_manager_project/ui/widgets/dialog_widget.dart';
import 'package:task_manager_project/ui/widgets/pass_text_form_field_widget.dart';
import 'package:task_manager_project/ui/widgets/sign_in_and_sign_up_rich_text_widget.dart';
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
  bool _postSignInUserInProgress = false;

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
                  height: 180,
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
                  validator: (value) =>
                      textFormFieldDefaultValidation(value, "Enter your email"),
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
                Visibility(
                  visible: _postSignInUserInProgress == false,
                  replacement: const CenteredCircularProgressIndicator(),
                  child: ElevatedButton(
                    onPressed: () {
                      _buildSignInButtonOnTap();
                    },
                    child: const Icon(
                      CupertinoIcons.arrow_right_circle,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60,
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
                      SignInAndSignUpRichTextWidget(
                        firstTextSpanText: "Don't have an account?",
                        secondTextSpanText: ' Sign up',
                        tapGestureRecognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, SignUpScreen.name);
                          },
                      )
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

  void _buildSignInButtonOnTap() {
    if (_formKey.currentState!.validate()) {
      _login();
    }
  }

  Future<void> _login() async {
    setState(() {
      _postSignInUserInProgress = true;
    });
    Map<String, String> loginPostRequestBody = {
      "email": _emailTEC.text.trim(),
      "password": _passTEC.text,
      // //we will not trim pass because some user can give space here.
    };

    NetworkResponse response = await NetworkCaller.postRequest(
      url: ApiUrls.loginUrl,
      body: loginPostRequestBody,
    );
    setState(() {
      _postSignInUserInProgress = false;
    });
    if (response.isSuccess) {
      String token = response.responseBody["token"];
      UserModel userModel = UserModel.fromResponseBodyJson(response
              .responseBody[
          "data"]); //we call named constructors in this way,like normal methods of a class.

      await AuthControllers.saveUserData(token, userModel);
      await AuthControllers
          .getUserData(); //when data is saved,it will get the data then
      Navigator.pushReplacementNamed(context, MainBottomNavScreen.name);
      snackBar(context: context, text: "Logged in successfully");
    } else if (response.statusCode == 401) {
      showDialogMethod(
          context: context,
          dialogTitle: 'Wrong credentials',
          contentText: 'Invalid username or password',
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok'),
            ),
          ]);
    } else {
      snackBar(context: context, text: response.errorMessage);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailTEC.dispose();
    _passTEC.dispose();
  }
}
