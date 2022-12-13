import 'package:flutter/material.dart';

import '../../widgets/widget.dart';

class WhiteBigButton extends StatelessWidget {
  const WhiteBigButton({
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
      style: pipeWhiteButtonStyle,
      onPressed: onPressed,
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 300.0,
          minWidth: 300.0,
          maxHeight: 70.0,
          minHeight: 70.0,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              label,
              style: TextStyle(
                color: color ?? Colors.black,
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
