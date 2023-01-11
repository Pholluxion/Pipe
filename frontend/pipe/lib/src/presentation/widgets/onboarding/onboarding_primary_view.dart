import 'package:flutter/material.dart';
import 'package:pipe/src/di.dart';
import 'package:pipe/src/data/services/navigation_service.dart';
import 'package:pipe/src/presentation/routes.dart' as routes;

import '../../../core/utils/colors.dart';
import '../widget.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return Hero(
      tag: 'init',
      transitionOnUserGestures: true,
      child: Scaffold(
        backgroundColor: PipeColor.kPipeBlack,
        body: SingleChildScrollView(
          child: SizedBox(
            width: (orientation == Orientation.portrait)
                ? size.height
                : size.width,
            height: (orientation == Orientation.portrait)
                ? size.height
                : size.height * 2,
            child: Column(
              mainAxisAlignment: (orientation != Orientation.portrait)
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.spaceEvenly,
              children: [
                const Flexible(child: PipeLogoTipo(h: 250)),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 32.0),
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 400.0,
                      minWidth: 400.0,
                      minHeight: 70.0,
                    ),
                    child: Text(
                      "Sit enim in minim cupidatat ipsum nulla ex irure cupidatat commodo. Aliquip ut esse elit officia anim sit pariatur mollit esse exercitation enim esse veniam nostrud. Lorem proident an Nulla nulla ipsum ullamco in nostrud. Proident aliquip enim do reprehenderit eu aliqua pariatur amet Lorem quis et quis.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: PipeColor.kPipeWhite,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: WhiteBigButton(
                    onPressed: () => di<NavigationService>()
                        .popAndNavigateTo(routes.kOnboarding2Route),
                    label: 'Empezar',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
