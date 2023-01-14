import 'package:pipe/src/data/models/user_data_model.dart';

import '../entities/user_data_entity.dart';
import '../repositories/auth_repository.dart';

class UpdateUserData {
  final AuthRepository authRepository;

  UpdateUserData({required this.authRepository});

  Future<UserDto> call(UserDataEntity userEntity) async {
    return await authRepository.updateUserData(userEntity);
  }
}
