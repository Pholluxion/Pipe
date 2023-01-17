import 'package:flutter/material.dart';
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
          child: LinearProgressIndicator(
            backgroundColor: PipeColor.kPipeBlack,
            color: PipeColor.kPipeGreen,
          ),
        ),
      ),
    );
  }
}
