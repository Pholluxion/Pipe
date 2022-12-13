import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home/home_cubit.dart';

import 'message_page.dart';
import 'profile_page.dart';
import 'stream_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.index == 0) {
          return const StreamPage();
        } else if (state.index == 1) {
          return const ProfilePage();
        } else {
          return const MessagePage();
        }
      },
    );
  }
}
