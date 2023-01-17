import 'package:flutter/material.dart';
import 'package:pipe/src/data/services/navigation_service.dart';
import 'package:pipe/src/di.dart';
import 'package:pipe/src/presentation/routes.dart' as routes;

import '../../../core/utils/colors.dart';
import '../widget.dart';

class OnboardingSecondPage extends StatelessWidget {
  const OnboardingSecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: PipeColor.kPipeBlack,
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: (orientation == Orientation.portrait)
              ? size.height
              : size.height * 2,
          child: Column(
            mainAxisAlignment: (orientation != Orientation.portrait)
                ? MainAxisAlignment.start
                : MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: SizedBox(
                  child: Image.asset("assets/images/pipe_logo_named.png"),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 400.0,
                      minWidth: 400.0,
                      minHeight: 70.0,
                    ),
                    child: Text(
                      "Eu dolor proident exercitation qui velit volupt.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: PipeColor.kPipeGreen,
                        fontSize: 23.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 48.0),
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 400.0,
                      minWidth: 400.0,
                      minHeight: 70.0,
                    ),
                    child: Text(
                      "Nulla nulla ipsum ullamco in nostrud. Proident aliquip enim do reprehenderit eu aliqua pariatur amet Lorem quis et quis.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: PipeColor.kPipeWhite,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 400.0),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GreenSmallButton(
                        onPressed: () => di<NavigationService>()
                            .popAndNavigateTo(routes.kRegisterRoute),
                        label: 'Registro',
                      ),
                      WhiteSmallButton(
                        onPressed: () => di<NavigationService>()
                            .popAndNavigateTo(routes.kLoginRoute),
                        label: 'Iniciar sesión',
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
