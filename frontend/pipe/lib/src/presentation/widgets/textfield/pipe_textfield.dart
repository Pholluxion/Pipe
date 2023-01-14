import 'package:flutter/material.dart';

import '../../../core/utils/colors.dart';
import 'pipe_textfield_style.dart';

class PipeTextField extends StatefulWidget {
  const PipeTextField({
    Key? key,
    this.onChanged,
    this.hintText,
    this.isEnable,
    this.value,
  }) : super(key: key);

  final void Function(String)? onChanged;
  final String? hintText;
  final bool? isEnable;
  final String? value;

  @override
  State<PipeTextField> createState() => _PipeTextFieldState();
}

class _PipeTextFieldState extends State<PipeTextField> {
  final pipeController = TextEditingController();

  @override
  void initState() {
    pipeController.text = widget.value ?? '';
    super.initState();
  }

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
          enabled: widget.isEnable ?? true,
          onChanged: widget.onChanged,
          controller: pipeController,
          keyboardType: TextInputType.text,
          cursorColor: PipeColor.kPipeGreen,
          style: TextStyle(color: PipeColor.kPipeWhite),
          decoration:
              PipeInputDecoration(hintText: widget.hintText).inputDecoration,
        ),
      ),
    );
  }
}
