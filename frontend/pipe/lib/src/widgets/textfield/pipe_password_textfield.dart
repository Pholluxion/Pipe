import 'package:flutter/material.dart';

import '../../core/utils/colors.dart';
import '../../core/utils/validations/password_validation.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    Key? key,
    this.onChanged,
    required this.errorText,
  }) : super(key: key);

  final void Function(String)? onChanged;
  final Password errorText;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  final passwordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
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
          controller: passwordController,
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          style: TextStyle(color: PipeColor.kPipeWhite),
          decoration: _inputDecorationPassword(widget.errorText),
        ),
      ),
    );
  }

  InputDecoration _inputDecorationPassword(Password password) {
    return InputDecoration(
      errorText: password.invalid ? 'La contraseña no es segura' : null,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: PipeColor.kPipeWhite,
        ),
        borderRadius: BorderRadius.circular(25.0),
      ),
      hintText: "Contraseña",
      hintStyle: TextStyle(color: PipeColor.kPipeWhite),
      labelStyle: TextStyle(color: PipeColor.kPipeWhite),
      suffixIcon: Icon(
        Icons.hide_source,
        color: PipeColor.kPipeWhite,
      ),
      suffixIconColor: PipeColor.kPipeWhite,
      focusColor: PipeColor.kPipeWhite,
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: PipeColor.kPipeWhite,
        ),
        borderRadius: BorderRadius.circular(25.0),
      ),
    );
  }
}
