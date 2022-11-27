import 'package:flutter/material.dart';

import '../widgets.dart';

class GreenSmallButton extends StatelessWidget {
  const GreenSmallButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.color,
  });

  final void Function()? onPressed;
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: pipeGreenButtonStyle,
      onPressed: onPressed,
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 120.0,
          minWidth: 120.0,
          maxHeight: 70.0,
          minHeight: 70.0,
        ),
        child: Center(
          child: FittedBox(
            child: Text(
              label,
              style: TextStyle(
                color: color ?? Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
