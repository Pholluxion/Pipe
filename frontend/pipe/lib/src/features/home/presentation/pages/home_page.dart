import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pipe/src/core/utils/colors.dart';
import 'package:pipe/src/features/login/presentation/cubit/login_cubit.dart';

import '../../../../core/settings/settings_controller.dart';
import '../../../../widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: PipeColor.kPipeBlack,
      body: Center(
        child: Column(
          children: [
            const PipeLogo(h: 150.0),
            Text(
              'Home page',
              style: TextStyle(
                color: PipeColor.kPipeWhite,
                fontSize: 30.0,
              ),
            ),
            BlocConsumer<LogInCubit, LogInState>(
              listener: (context, state) {
                if (state.username.isEmpty) {
                  Navigator.popAndPushNamed(context, "login");
                }
              },
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    children: [
                      Text(
                        'Bienvenido ${settingsController.prefs.getString('user') ?? state.username}',
                        style: TextStyle(
                          color: PipeColor.kPipeWhite,
                          fontSize: 20.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32.0),
                        child: GreenSmallButton(
                            onPressed: () => context
                                .read<LogInCubit>()
                                .logOutFormSubmitted(),
                            label: 'Cerrar sesión'),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
