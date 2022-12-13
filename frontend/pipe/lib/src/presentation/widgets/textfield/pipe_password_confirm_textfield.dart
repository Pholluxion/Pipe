import 'package:flutter/material.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/validations/password_confirm_validation.dart';

class ConfirmPasswordTextField extends StatefulWidget {
  const ConfirmPasswordTextField({
    Key? key,
    this.onChanged,
    required this.errorText,
  }) : super(key: key);

  final void Function(String)? onChanged;
  final ConfirmedPassword errorText;

  @override
  State<ConfirmPasswordTextField> createState() =>
      _ConfirmPasswordTextFieldState();
}

class _ConfirmPasswordTextFieldState extends State<ConfirmPasswordTextField> {
  final passwordController = TextEditingController();
  bool _isOscure = true;

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
          obscureText: _isOscure,
          keyboardType: TextInputType.visiblePassword,
          style: TextStyle(color: PipeColor.kPipeWhite),
          decoration: _inputDecorationPasswordConfirm(widget.errorText),
        ),
      ),
    );
  }

  InputDecoration _inputDecorationPasswordConfirm(
    ConfirmedPassword confirmedPassword,
  ) {
    return InputDecoration(
      errorText:
          confirmedPassword.invalid ? 'Las contraseñas no coinciden' : null,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: PipeColor.kPipeWhite,
        ),
        borderRadius: BorderRadius.circular(25.0),
      ),
      hintText: "Confirmar contraseña",
      hintStyle: TextStyle(color: PipeColor.kPipeWhite),
      labelStyle: TextStyle(color: PipeColor.kPipeWhite),
      suffixIcon: IconButton(
        color: PipeColor.kPipeWhite,
        icon: const Icon(
          Icons.hide_source,
        ),
        onPressed: () {
          _isOscure = !_isOscure;
          setState(() {});
        },
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
