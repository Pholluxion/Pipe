import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pipe/src/core/utils/colors.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PipeColor.kPipeGreen,
      body: Center(
        child: SizedBox(
          width: 150.0,
          height: 150.0,
          child: FittedBox(
            child: Lottie.asset(
              fit: BoxFit.contain,
              'assets/lotties/loading_lottie.json',
            ),
          ),
        ),
      ),
    );
  }
}
