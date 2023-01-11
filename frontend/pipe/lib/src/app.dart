import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'di.dart';
import 'core/settings/settings_controller.dart';
import 'core/themes/pipe_theme.dart';
import 'data/services/navigation_service.dart';
import 'presentation/bloc/actions/actions_bloc.dart';
import 'presentation/bloc/camera/camera_bloc.dart';
import 'presentation/bloc/home/home_cubit.dart';
import 'presentation/bloc/login/login_cubit.dart';
import 'presentation/bloc/microfone/microfone_cubit.dart';
import 'presentation/bloc/signup/signup_cubit.dart';
import 'presentation/bloc/video/video_sdk_bloc.dart';
import 'presentation/router.dart';
import 'presentation/routes.dart' as routes;

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
        BlocProvider(create: (context) => di<HomeCubit>()),
        BlocProvider(create: (context) => di<LogInCubit>()),
        BlocProvider(create: (context) => di<CameraBloc>()),
        BlocProvider(create: (context) => di<SignUpCubit>()),
        BlocProvider(create: (context) => di<ActionsBloc>()),
        BlocProvider(create: (context) => di<VideoSdkBloc>()),
        BlocProvider(create: (context) => di<MicrofoneCubit>()),
      ],
      child: MaterialApp(
        initialRoute: _initPath(),
        onGenerateRoute: generateRoute,
        navigatorKey: di<NavigationService>().navigatorKey,
        theme: pipeTheme,
        darkTheme: pipeTheme,
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  String _initPath() {
    if (isOnboardingActive) {
      return routes.kOnboardingRoute;
    } else {
      return routes.kLoginRoute;
    }
  }
}
