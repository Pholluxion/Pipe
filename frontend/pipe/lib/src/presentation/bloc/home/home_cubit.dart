import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pipe/src/data/models/user_data_model.dart';
import 'package:pipe/src/di.dart';
import 'package:pipe/src/domain/entities/user_data_entity.dart';
import 'package:pipe/src/domain/usecases/update_userdata_usecase.dart';

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

  Future<UserDto> updateUserData() async {
    return await di
        .get<UpdateUserData>()
        .call(state.userResponseEntity!.userDto!);
  }

  void updateUserDto(UserDataEntity userDataEntity) {
    emit(
      state.copyWith(
        userResponseEntity: UserResponseEntity(userDto: userDataEntity),
      ),
    );
  }
}
