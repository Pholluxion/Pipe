import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/themes/pipe_theme.dart';
import 'core/settings/settings_controller.dart';
import 'presentation/bloc/home/home_cubit.dart';
import 'presentation/bloc/login/login_cubit.dart';
import 'presentation/bloc/signup/signup_cubit.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/pages/signup_page.dart';
import 'presentation/widgets/widget.dart';

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
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(
          create: (context) => LogInCubit(
            context.read<HomeCubit>(),
          ),
        ),
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
    } else {
      return 'login';
    }
  }
}
