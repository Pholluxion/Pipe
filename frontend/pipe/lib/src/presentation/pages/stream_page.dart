import 'package:flutter/material.dart';

import '../../core/utils/colors.dart';
import '../widgets/widget.dart';

class StreamPage extends StatelessWidget {
  const StreamPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      backgroundColor: PipeColor.kPipeBlack,
      appBar: PipeAppBar(size: size),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Wrap(
                  children: List.generate(
                    10,
                    (index) => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: 400.0,
                        height: 200.0,
                        decoration: BoxDecoration(
                          color: PipeColor.kPipeGreen,
                          borderRadius: BorderRadius.circular(
                            20.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: orientation == Orientation.landscape ? const PipeDrawer() : null,
      bottomNavigationBar:
          orientation == Orientation.portrait ? const PipeNavBar() : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Center(child: Text('Nueva reunion')),
              content: const Text(
                  'Por favor verifica tus datos e intenta nuevamente.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        },
        child: Icon(
          Icons.video_call,
          color: PipeColor.kPipeBlack,
        ),
      ),
    );
  }
}
