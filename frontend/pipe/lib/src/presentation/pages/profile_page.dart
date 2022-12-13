import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/colors.dart';
import '../bloc/home/home_cubit.dart';
import '../widgets/widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);
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
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      return Text(
                        state.userResponseEntity?.userDto
                                ?.toJson()
                                .toString() ??
                            '',
                        style: TextStyle(
                          color: PipeColor.kPipeWhite,
                          fontSize: 20.0,
                        ),
                      );
                    },
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
