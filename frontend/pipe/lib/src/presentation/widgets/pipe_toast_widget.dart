import 'package:flutter/material.dart';
import 'package:pipe/src/core/utils/colors.dart';

void showSnackBarMessage({
  required String message,
  Widget? icon,
  Color messageColor = Colors.white,
  required BuildContext context,
}) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: PipeColor.kPipeGreen,
      duration: const Duration(milliseconds: 800),
      content: Container(
        constraints: const BoxConstraints(
          maxWidth: 120.0,
          minWidth: 120.0,
          maxHeight: 30.0,
          minHeight: 30.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: icon ??
                  Icon(
                    Icons.add_alert_rounded,
                    color: PipeColor.kPipeWhite,
                  ),
            ),
            Flexible(
              child: Text(
                textAlign: TextAlign.center,
                message,
                style: TextStyle(
                  color: messageColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.fade,
              ),
            )
          ],
        ),
      ),
    ),
  );
}
