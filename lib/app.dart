import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
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

class TaskManagementApp extends StatefulWidget {
  const TaskManagementApp({super.key});

  @override
  State<TaskManagementApp> createState() => _TaskManagementAppState();
}

class _TaskManagementAppState extends State<TaskManagementApp> {
  @override
  void initState() {
    initialization();
    super.initState();
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 6));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    const chipThemeData = ChipThemeData(
      padding: EdgeInsets.symmetric(horizontal: 16),
      backgroundColor: AppColors.themeColor,
      elevation: 0,
      labelStyle: TextStyle(
          color: Colors.black, fontSize: 11, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 0, color: Colors.transparent),
        borderRadius: BorderRadius.all(
          Radius.circular(32),
        ),
      ),
    );
    const inputDecorationTheme = InputDecorationTheme(
      contentPadding: EdgeInsets.all(14),
      fillColor: Colors.white,
      filled: true,
      hintStyle: TextStyle(
        fontWeight: FontWeight.w400,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
    );
    final lightTheme = ThemeData(
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.black, backgroundColor: AppColors.themeColor),
      listTileTheme: const ListTileThemeData(
        tileColor: Colors.transparent,
      ),
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.transparent,
      chipTheme: chipThemeData,
      appBarTheme: const AppBarTheme(
        actionsIconTheme: IconThemeData(color: Colors.black),
        backgroundColor: AppColors.themeColor,
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
        bodySmall: const TextStyle(color: Colors.black),
        labelLarge: const TextStyle(color: Colors.black),
        labelMedium:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        titleMedium:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        titleLarge: const TextStyle(
            fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
        labelSmall: const TextStyle(color: Colors.white),
        bodyMedium:
            TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500),
      ),
      inputDecorationTheme: inputDecorationTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            iconSize: 32,
            foregroundColor: Colors.white,
            fixedSize: const Size.fromWidth(double.maxFinite),
            padding: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: AppColors.themeColor),
      ),
    );
    return MaterialApp(
        themeMode: ThemeMode.system,
        title: 'Task Manager',
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        theme: lightTheme,
        darkTheme: lightTheme.copyWith(
            outlinedButtonTheme: const OutlinedButtonThemeData(
                style: ButtonStyle(
                    textStyle: WidgetStatePropertyAll(
                        TextStyle(color: Colors.greenAccent)),
                    side: WidgetStatePropertyAll(
                        BorderSide(color: Colors.white70)))),
            dialogTheme: DialogThemeData(backgroundColor: Colors.grey[900]),
            inputDecorationTheme: inputDecorationTheme.copyWith(
              fillColor: Colors.grey[900],
              hintStyle: const TextStyle(
                  fontWeight: FontWeight.w400, color: Colors.white),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            navigationBarTheme: NavigationBarThemeData(
                iconTheme: WidgetStateProperty.resolveWith((state) {
                  if (state.contains(WidgetState.selected)) {
                    return const IconThemeData(color: Colors.black);
                  } else {
                    return const IconThemeData(color: Colors.white);
                  }
                }),
                backgroundColor: Colors.black,
                labelTextStyle: WidgetStateProperty.resolveWith((state) {
                  if (state.contains(WidgetState.selected)) {
                    return const TextStyle(color: Colors.white);
                  } else {
                    return const TextStyle(color: Colors.white70);
                  }
                })),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
                foregroundColor: Colors.white,
                backgroundColor: AppColors.themeColor),
            chipTheme: chipThemeData.copyWith(
              labelStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w600),
            ),
            listTileTheme: const ListTileThemeData(
                tileColor: Colors.transparent,
                subtitleTextStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white70,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                )),
            cardTheme: CardThemeData(
              color: Colors.grey[900],
            ),
            textTheme: TextTheme(
              bodySmall: const TextStyle(color: Colors.black),
              labelLarge: const TextStyle(color: Colors.black),
              labelMedium: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              labelSmall: const TextStyle(color: Colors.white),
              titleLarge: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              titleMedium: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white),
              bodyMedium: TextStyle(
                  color: Colors.grey[300], fontWeight: FontWeight.w500),
            ),
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Colors.black),
        debugShowCheckedModeBanner: false,
        initialRoute: SignInScreen.name,
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
          } else if (settings.name == UpdateProfileScreen.name) {
            widget = const UpdateProfileScreen();
          }
          return MaterialPageRoute(builder: (BuildContext context) {
            return widget;
          });
        });
  }
}
