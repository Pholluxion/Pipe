import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pipe/src/di.dart';
import 'package:pipe/src/presentation/routes.dart' as routes;

import '../../data/services/navigation_service.dart';
import '../bloc/home/home_cubit.dart';

import '../bloc/login/login_cubit.dart';
import 'message_page.dart';
import 'profile_page.dart';
import 'stream_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _showErrorDialog(context);
        return true;
      },
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.index == 0) {
            return StreamPage(
              token: state.token,
            );
          } else if (state.index == 1) {
            return const ProfilePage();
          } else {
            return const MessagePage();
          }
        },
      ),
    );
  }

  Future<void> _showErrorDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('¿Deseas cerrar sesión?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => di<NavigationService>().goBack(),
            child: const Text('Nop'),
          ),
          TextButton(
              onPressed: () {
                context.read<LogInCubit>().logOutFormSubmitted();
                di<NavigationService>().goBack();
                di<NavigationService>().popAndNavigateTo(routes.kLoginRoute);
              },
              child: const Text('Cerrar sesión'))
        ],
      ),
    );
  }
}
