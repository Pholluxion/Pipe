import 'package:flutter/material.dart';

import '../../core/utils/colors.dart';

class PipeDivider extends StatelessWidget {
  const PipeDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0,
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 350.0),
        child: Divider(
          color: PipeColor.kPipeWhite,
          height: 20.0,
          thickness: 1.0,
        ),
      ),
    );
  }
}
