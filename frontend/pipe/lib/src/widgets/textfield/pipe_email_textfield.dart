import 'package:flutter/material.dart';

import '../../core/utils/colors.dart';
import '../../core/utils/validations/email_validation.dart';

class EmailTextField extends StatefulWidget {
  const EmailTextField({
    Key? key,
    this.onChanged,
    required this.errorText,
  }) : super(key: key);

  final void Function(String)? onChanged;
  final Email errorText;

  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 350.0),
        child: TextField(
          onChanged: widget.onChanged,
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          cursorColor: PipeColor.kPipeGreen,
          style: TextStyle(color: PipeColor.kPipeWhite),
          decoration: InputDecoration(
            errorText: widget.errorText.invalid ? 'Correo inválido' : null,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: PipeColor.kPipeWhite,
              ),
              borderRadius: BorderRadius.circular(25.0),
            ),
            hintText: "Correo electrónico",
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
          ),
        ),
      ),
    );
  }
}
