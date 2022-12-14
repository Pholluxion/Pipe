import 'package:flutter/material.dart';

import '../../../core/utils/colors.dart';

final inputDecoration = InputDecoration(
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: PipeColor.kPipeWhite,
    ),
    borderRadius: BorderRadius.circular(25.0),
  ),
  hintText: "Nombre completo",
  errorBorder: OutlineInputBorder(
    gapPadding: 10.0,
    borderSide: BorderSide(
      color: PipeColor.kPipeWhite,
      width: 2.0,
    ),
    borderRadius: BorderRadius.circular(25.0),
  ),
  focusColor: PipeColor.kPipeWhite,
  hintStyle: TextStyle(color: PipeColor.kPipeWhite),
  labelStyle: TextStyle(color: PipeColor.kPipeWhite),
  border: OutlineInputBorder(
    gapPadding: 10.0,
    borderSide: BorderSide(
      color: PipeColor.kPipeWhite,
      width: 2.0,
    ),
    borderRadius: BorderRadius.circular(25.0),
  ),
);
