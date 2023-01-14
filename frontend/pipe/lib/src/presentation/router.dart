import 'package:flutter/material.dart';
import 'package:pipe/src/presentation/pages/conference_page.dart';
import 'package:pipe/src/presentation/pages/join_page.dart';
import 'package:pipe/src/presentation/pages/loading_page.dart';
import 'package:pipe/src/presentation/routes.dart' as routes;
import 'package:pipe/src/presentation/pages/home_page.dart';
import 'package:pipe/src/presentation/pages/login_page.dart';
import 'package:pipe/src/presentation/pages/signup_page.dart';
import 'package:pipe/src/presentation/widgets/widget.dart';

import 'pages/metting_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case routes.kLoginRoute:
      return MaterialPageRoute(builder: (context) => const LoginPage());
    case routes.kHomeRoute:
      return MaterialPageRoute(builder: (context) => const HomePage());
    case routes.kOnboardingRoute:
      return MaterialPageRoute(builder: (context) => const OnboardingView());
    case routes.kOnboarding2Route:
      return MaterialPageRoute(
          builder: (context) => const OnboardingSecondPage());
    case routes.kRegisterRoute:
      return MaterialPageRoute(builder: (context) => const RegisterPage());
    case routes.kNewMettingPage:
      return MaterialPageRoute<void>(
        builder: (BuildContext context) => const NewMettingPage(),
        fullscreenDialog: true,
      );
    case routes.kJoinPage:
      return MaterialPageRoute<void>(
        builder: (BuildContext context) => const JoinPage(),
        fullscreenDialog: true,
      );
    case routes.kLoadingPage:
      return MaterialPageRoute<void>(
        builder: (BuildContext context) => const LoadingPage(),
        fullscreenDialog: true,
      );
    case routes.kConferencePage:
      return MaterialPageRoute<void>(
        builder: (BuildContext context) => const ConfereneceMeetingScreen(),
        fullscreenDialog: true,
      );

    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
  }
}
