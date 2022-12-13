import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/colors.dart';
import '../bloc/home/home_cubit.dart';

class PipeNavBar extends StatelessWidget {
  const PipeNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return BottomNavigationBar(
          elevation: 5,
          type: BottomNavigationBarType.fixed,
          onTap: context.read<HomeCubit>().changeIndex,
          currentIndex: state.index,
          backgroundColor: PipeColor.kPipeBlack,
          unselectedItemColor: PipeColor.kPipeWhite,
          unselectedIconTheme: IconThemeData(
            color: PipeColor.kPipeWhite,
            size: 20,
          ),
          selectedIconTheme: IconThemeData(
            color: PipeColor.kPipeGreen,
            size: 30,
          ),
          mouseCursor: SystemMouseCursors.grab,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.stream_sharp),
              label: 'Calls',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Messages',
            ),
          ],
        );
      },
    );
  }
}
