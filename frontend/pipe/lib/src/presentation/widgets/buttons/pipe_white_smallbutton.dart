import 'package:flutter/material.dart';

import '../../../core/utils/colors.dart';
import '../../widgets/widget.dart';

class WhiteSmallButton extends StatelessWidget {
  const WhiteSmallButton({
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
                color: PipeColor.kPipeBlack,
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
