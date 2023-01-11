import 'package:flutter/material.dart';

import '../../core/utils/colors.dart';
import '../widgets/widget.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: PipeColor.kPipeBlack,
      appBar: PipeAppBar(size: size),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                children: [
                  Text(
                    "Messages",
                    style: TextStyle(color: PipeColor.kPipeWhite),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: orientation == Orientation.landscape ? const PipeDrawer() : null,
      bottomNavigationBar:
          orientation == Orientation.portrait ? const PipeNavBar() : null,
    );
  }
}
