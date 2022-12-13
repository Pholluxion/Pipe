import 'package:flutter/material.dart';

import '../../../core/utils/colors.dart';
import '../widget.dart';

class OnboardingSecondPage extends StatelessWidget {
  const OnboardingSecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return Hero(
      tag: 'init',
      child: Scaffold(
        backgroundColor: PipeColor.kPipeBlack,
        body: Center(
          child: SingleChildScrollView(
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
                  SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: Image.asset("assets/images/pipe_logo_named.png"),
                  ),
                  Padding(
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
                  Padding(
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
                  Container(
                    constraints: const BoxConstraints(maxWidth: 400.0),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GreenSmallButton(
                          onPressed: () =>
                              Navigator.popAndPushNamed(context, "register"),
                          label: 'Registro',
                        ),
                        WhiteSmallButton(
                          onPressed: () =>
                              Navigator.popAndPushNamed(context, "login"),
                          label: 'Iniciar sesión',
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
