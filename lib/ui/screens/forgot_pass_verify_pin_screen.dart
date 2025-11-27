import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_project/ui/screens/forgot_pass_set_pass_screen.dart';
import 'package:task_manager_project/ui/utils/app_colors.dart';
import 'package:task_manager_project/ui/widgets/back_to_sign_in_button_widget.dart';
import 'package:task_manager_project/ui/widgets/background_screen_widget.dart';

class ForgotPassVerifyPinScreen extends StatefulWidget {
  const ForgotPassVerifyPinScreen({super.key});

  static const String name = '/forgot_pass/verify_pin';

  @override
  State<ForgotPassVerifyPinScreen> createState() =>
      _ForgotPassVerifyPinScreenState();
}

class _ForgotPassVerifyPinScreenState extends State<ForgotPassVerifyPinScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pinTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {

    TextTheme textTheme = Theme.of(context).textTheme;
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
                    'PIN Verification',
                    style: textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'A 6 digit verification pin has been sent to your email address',
                    style: textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  buildPinCodeTextField(),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, ForgotPassSetPassScreen.name);
                    },
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

  Widget buildPinCodeTextField() {
    final bool lightMode = Theme.of(context).brightness == Brightness.light;
    return PinCodeTextField(
      controller: _pinTEC,
      keyboardType: TextInputType.number,
      appContext: context,
      length: 6,
      backgroundColor: Colors.transparent,
      enableActiveFill: true,
      animationType: AnimationType.fade,
      showCursor: true,
      cursorColor: lightMode ? Colors.black : Colors.white,
      animationDuration: const Duration(milliseconds: 300),
      pinTheme: PinTheme(
        fieldHeight: 50,
        fieldWidth: 50,
        activeFillColor: lightMode ? Colors.white : Colors.grey[900],
        inactiveFillColor:lightMode ? Colors.white : Colors.grey[900],
        selectedFillColor: lightMode ? Colors.white : Colors.grey[900],
        selectedColor: AppColors.themeColor,
        inactiveColor: Colors.grey,
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pinTEC.dispose();
  }
}
