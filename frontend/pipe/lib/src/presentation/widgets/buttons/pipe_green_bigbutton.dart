import 'package:flutter/material.dart';
import 'package:pipe/src/core/utils/colors.dart';

import '../../widgets/widget.dart';

class GreenBigButton extends StatelessWidget {
  const GreenBigButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.color,
    this.loading,
  });

  final void Function()? onPressed;
  final String label;
  final Color? color;
  final bool? loading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        style: pipeGreenButtonStyle,
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
              child: (loading != null && loading == true)
                  ? LinearProgressIndicator(
                      backgroundColor: PipeColor.kPipeWhite,
                      color: PipeColor.kPipeBlack,
                    )
                  : Text(
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
      ),
    );
  }
}
