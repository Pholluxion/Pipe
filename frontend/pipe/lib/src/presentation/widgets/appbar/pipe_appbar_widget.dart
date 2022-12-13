import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pipe/src/presentation/widgets/widget.dart';

import '../../../core/utils/colors.dart';
import '../../bloc/login/login_cubit.dart';

class PipeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const PipeAppBar({super.key, required this.size});

  final Size size;

  @override
  State<PipeAppBar> createState() => _PipeAppBarState();

  @override
  Size get preferredSize => Size(size.width, size.height * 0.1);
}

class _PipeAppBarState extends State<PipeAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const PipeLogoTipo(h: 50),
      centerTitle: true,
      surfaceTintColor: PipeColor.kPipeWhite,
      backgroundColor: PipeColor.kPipeBlack,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {
              context.read<LogInCubit>().logOutFormSubmitted();
              Navigator.popUntil(context, ModalRoute.withName('login'));
              Navigator.pushNamed(context, 'login');
            },
            icon: Icon(
              Icons.power_settings_new,
              color: PipeColor.kPipeGreen,
            ),
          ),
        )
      ],
    );
  }
}
