import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pipe/src/bloc_observer.dart';
import 'package:pipe/src/core/settings/settings_controller.dart';

import 'package:pipe/src/di.dart' as di_auth;

import 'src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await settingsController.init();
  Bloc.observer = AppBlocObserver();

  di_auth.init();

  runApp(const MyApp());
}
