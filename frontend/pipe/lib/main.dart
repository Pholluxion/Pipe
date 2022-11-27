import 'package:flutter/material.dart';
import 'package:pipe/src/core/settings/settings_controller.dart';

import 'package:pipe/src/injectors/di_signup.dart' as di_signup;
import 'package:pipe/src/injectors/di_login.dart' as di_login;

import 'src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await settingsController.init();

  di_signup.init();
  di_login.init();

  runApp(const MyApp());
}
