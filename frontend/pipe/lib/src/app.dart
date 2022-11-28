import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pipe/src/core/themes/pipe_theme.dart';

import 'core/settings/settings_controller.dart';

import 'features/onboarding/views/onboarding_primary_view.dart';
import 'features/onboarding/views/onboarding_second_view.dart';
import 'features/login/presentation/cubit/login_cubit.dart';
import 'features/login/presentation/pages/login_page.dart';
import 'features/signup/presentation/cubit/signup_cubit.dart';
import 'features/signup/presentation/pages/signup_page.dart';
import 'features/home/presentation/pages/home_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool isOnboardingActive;
  late String isUserActive;

  @override
  void initState() {
    isOnboardingActive = settingsController.showOnboarding();
    isUserActive = settingsController.prefs.getString('user') ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignUpCubit()),
        BlocProvider(create: (context) => LogInCubit()),
      ],
      child: MaterialApp(
        routes: {
          "onboarding": (context) => const OnboardingView(),
          "onboardingPage2": (context) => const OnboardingSecondPage(),
          "login": (context) => const LoginPage(),
          "register": (context) => const RegisterPage(),
          "home": (context) => const HomePage(),
        },
        initialRoute: _initPath(),
        theme: pipeTheme,
        darkTheme: pipeTheme,
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  String _initPath() {
    if (isOnboardingActive) {
      return 'onboarding';
    } else if (isUserActive.isEmpty) {
      return 'login';
    } else {
      return 'home';
    }
  }
}
