import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

final pipeTheme = ThemeData(
  textTheme: GoogleFonts.redHatMonoTextTheme(),
  primaryColor: PipeColor.kPipeBlack,
  secondaryHeaderColor: PipeColor.kPipeGreen,
  primaryColorDark: PipeColor.kPipeWhite,
  backgroundColor: PipeColor.kPipeBlack,
  highlightColor: PipeColor.kPipeGreen,
  indicatorColor: PipeColor.kPipeGreen,
  colorScheme: ThemeData().colorScheme.copyWith(
        primary: PipeColor.kPipeGreen,
        secondary: PipeColor.kPipeWhite,
      ),
  inputDecorationTheme: InputDecorationTheme(
    hoverColor: PipeColor.kPipeGreen,
    focusColor: PipeColor.kPipeGreen,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: PipeColor.kPipeWhite,
      ),
      borderRadius: BorderRadius.circular(25.0),
    ),
  ),
);
