import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pipe/src/presentation/bloc/bloc_observer.dart';
import 'package:pipe/src/core/settings/settings_controller.dart';

import 'package:pipe/src/di.dart' as di_auth;

import 'src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await settingsController.init();
  Bloc.observer = AppBlocObserver();
  if (!dotenv.isInitialized) {
    // Load Environment variables
    await dotenv.load(fileName: ".env");
  }

  di_auth.init();

  runApp(const MyApp());
}
