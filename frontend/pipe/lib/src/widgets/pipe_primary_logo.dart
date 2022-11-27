import 'package:flutter/material.dart';

class PipeLogoTipo extends StatelessWidget {
  const PipeLogoTipo({super.key, required this.h});
  final double h;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: h,
      width: double.infinity,
      child: Image.asset("assets/images/pipe_logo_named.png"),
    );
  }
}
