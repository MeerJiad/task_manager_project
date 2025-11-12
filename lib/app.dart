import 'package:flutter/material.dart';
import 'package:task_manager_project/ui/screens/add_new_task_screen.dart';
import 'package:task_manager_project/ui/screens/forgot_pass_set_pass_screen.dart';
import 'package:task_manager_project/ui/screens/forgot_pass_verify_email_screen.dart';
import 'package:task_manager_project/ui/screens/forgot_pass_verify_pin_screen.dart';
import 'package:task_manager_project/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager_project/ui/screens/sign_in_screen.dart';
import 'package:task_manager_project/ui/screens/sign_up_screen.dart';
import 'package:task_manager_project/ui/screens/splash_screen.dart';
import 'package:task_manager_project/ui/screens/update_profile_screen.dart';
import 'package:task_manager_project/ui/utils/app_colors.dart';

class TaskManagementApp extends StatelessWidget {
  const TaskManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        theme: ThemeData(
          chipTheme: const ChipThemeData(
            padding: EdgeInsets.symmetric(horizontal: 16),
            backgroundColor: AppColors.themeColor,
            elevation: 0,
            labelStyle: TextStyle(
                color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 0, color: Colors.transparent),
              borderRadius: BorderRadius.all(
                Radius.circular(32),
              ),
            ),
          ),
          appBarTheme: const AppBarTheme(
            actionsIconTheme: IconThemeData(color: Colors.black),
            color: AppColors.themeColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey.shade600,
              textStyle: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          colorSchemeSeed: AppColors.themeColor,
          textTheme: TextTheme(
            titleLarge: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
            labelSmall: const TextStyle(color: Colors.white),
            bodyMedium:
                TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            contentPadding: EdgeInsets.all(14),
            fillColor: Colors.white,
            filled: true,
            hintStyle: TextStyle(
              fontWeight: FontWeight.w300,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                fixedSize: const Size.fromWidth(double.maxFinite),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: AppColors.themeColor),
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.name,
        onGenerateRoute: (RouteSettings settings) {
          late Widget widget;
          if (settings.name == SplashScreen.name) {
            widget = const SplashScreen();
          } else if (settings.name == SignInScreen.name) {
            widget = const SignInScreen();
          } else if (settings.name == SignUpScreen.name) {
            widget = const SignUpScreen();
          } else if (settings.name == ForgotPassEmailVerifyScreen.name) {
            widget = const ForgotPassEmailVerifyScreen();
          } else if (settings.name == ForgotPassVerifyPinScreen.name) {
            widget = const ForgotPassVerifyPinScreen();
          } else if (settings.name == ForgotPassSetPassScreen.name) {
            widget = const ForgotPassSetPassScreen();
          } else if (settings.name == MainBottomNavScreen.name) {
            widget = const MainBottomNavScreen();
          } else if (settings.name == AddNewTaskScreen.name) {
            widget = const AddNewTaskScreen();
          }else if(settings.name == UpdateProfileScreen.name){
            widget = const UpdateProfileScreen();
          }
          return MaterialPageRoute(builder: (BuildContext context) {
            return widget;
          });
        });
  }
}
