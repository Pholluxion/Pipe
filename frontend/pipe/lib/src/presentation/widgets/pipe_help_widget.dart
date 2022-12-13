import 'package:flutter/material.dart';

import '../../core/utils/colors.dart';

class HelpBtn extends StatelessWidget {
  const HelpBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 350.0),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              "Si necesitas apoyo ",
              style: TextStyle(color: PipeColor.kPipeWhite),
            ),
            TextButton(
              onPressed: () {},
              child: const Text("haz click Aqui"),
            )
          ],
        ),
      ),
    );
  }
}
