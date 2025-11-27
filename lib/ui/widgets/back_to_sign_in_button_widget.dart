import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_project/ui/screens/sign_in_screen.dart';
import '../utils/app_colors.dart';

class BackToSignInButton extends StatelessWidget {
  const BackToSignInButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamedAndRemoveUntil(
            context, SignInScreen.name, (predicate) => false);
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.arrow_left_circle,
            color: AppColors.themeColor,
          ),
          SizedBox(
            width: 8,
          ),
          Text('Back to sign in'),
        ],
      ),
    );
  }
}
