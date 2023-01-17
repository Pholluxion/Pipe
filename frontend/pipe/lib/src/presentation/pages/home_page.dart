import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pipe/src/di.dart';
import 'package:pipe/src/presentation/routes.dart' as routes;

import '../../data/services/navigation_service.dart';
import '../bloc/home/home_cubit.dart';

import '../bloc/login/login_cubit.dart';
import 'profile_page.dart';
import 'stream_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('¿Deseas cerrar sesión?'),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    context.read<LogInCubit>().logOutFormSubmitted();
                    di<NavigationService>().goBack();
                    di<NavigationService>()
                        .popAndNavigateTo(routes.kLoginRoute);
                  },
                  child: const Text('Si'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.index == 0) {
            return StreamPage(
              token: state.token,
            );
          } else {
            return const ProfilePage();
          }
        },
      ),
    );
  }
}
