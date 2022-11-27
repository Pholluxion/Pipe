import 'package:flutter/material.dart';
import 'package:pipe/src/core/utils/colors.dart';

final pipeGreenButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(PipeColor.kPipeGreen),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
      side: const BorderSide(),
    ),
  ),
);

final pipeWhiteButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(PipeColor.kPipeWhite),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
      side: const BorderSide(),
    ),
  ),
);
