import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pipe/src/core/utils/colors.dart';

import '../../bloc/home/home_cubit.dart';
import '../widget.dart';

class PipeDrawer extends StatelessWidget {
  const PipeDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: PipeColor.kPipeBlack,
      elevation: 10.0,
      child: Column(
        children: [
          const DrawerHeader(
              decoration: BoxDecoration(), child: PipeLogo(h: 1)),
          ListTile(
            onTap: () => context.read<HomeCubit>().changeIndex(0),
            leading: const Icon(Icons.stream_sharp),
            iconColor: PipeColor.kPipeGreen,
            title: Text(
              'Streams',
              style: TextStyle(
                color: PipeColor.kPipeWhite,
              ),
            ),
          ),
          ListTile(
            onTap: () => context.read<HomeCubit>().changeIndex(1),
            leading: const Icon(Icons.person),
            iconColor: PipeColor.kPipeGreen,
            title: Text(
              'Profile',
              style: TextStyle(
                color: PipeColor.kPipeWhite,
              ),
            ),
          ),
          ListTile(
            onTap: () => context.read<HomeCubit>().changeIndex(2),
            leading: const Icon(Icons.message),
            iconColor: PipeColor.kPipeGreen,
            title: Text(
              'Messages',
              style: TextStyle(
                color: PipeColor.kPipeWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
