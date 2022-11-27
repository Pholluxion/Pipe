import 'package:flutter/material.dart';

class PipeLogo extends StatelessWidget {
  const PipeLogo({super.key, required this.h});
  final double h;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: h,
      width: double.infinity,
      child: Image.asset("assets/images/pipe_logo.png"),
    );
  }
}
