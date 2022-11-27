import 'package:flutter/material.dart';

import 'package:pipe/src/core/utils/colors.dart';
import 'package:pipe/src/widgets/widgets.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PipeColor.kPipeBlack,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const PipeLogoTipo(h: 250),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 300.0,
                  minWidth: 300.0,
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 300.0,
                  minWidth: 300.0,
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
                onPressed: () =>
                    Navigator.popAndPushNamed(context, "onboardingPage2"),
                label: 'Empezar',
              ),
            )
          ],
        ),
      ),
    );
  }
}
