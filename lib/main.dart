import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:task_manager_project/app.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(DevicePreview(enabled: false,
    builder: (BuildContext context) {

      return const TaskManagementApp();
    },

  ));
}
