import 'package:flutter/material.dart';

import '../../../core/utils/colors.dart';
import 'pipe_textfield_style.dart';

class PipeTextField extends StatefulWidget {
  const PipeTextField({Key? key, this.onChanged}) : super(key: key);

  final void Function(String)? onChanged;

  @override
  State<PipeTextField> createState() => _PipeTextFieldState();
}

class _PipeTextFieldState extends State<PipeTextField> {
  final pipeController = TextEditingController();

  @override
  void dispose() {
    pipeController.dispose();
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
          controller: pipeController,
          keyboardType: TextInputType.emailAddress,
          cursorColor: PipeColor.kPipeGreen,
          style: TextStyle(color: PipeColor.kPipeWhite),
          decoration: inputDecoration,
        ),
      ),
    );
  }
}
