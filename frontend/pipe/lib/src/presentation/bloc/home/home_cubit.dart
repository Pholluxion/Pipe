import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/user_response_entity.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void loadUser(
    UserResponseEntity userResponseEntity,
    String token,
  ) {
    emit(
      state.copyWith(
        userResponseEntity: userResponseEntity,
        token: token,
      ),
    );
  }

  void changeIndex(int index) {
    emit(
      state.copyWith(index: index),
    );
  }
}
