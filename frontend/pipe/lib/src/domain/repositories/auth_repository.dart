import 'package:pipe/src/data/models/user_data_model.dart';

import '../entities/user_data_entity.dart';
import '../entities/user_entity.dart';
import '../entities/user_response_entity.dart';

abstract class AuthRepository {
  Future<String> register(UserEntity user);
  Future<UserResponseEntity> login(UserEntity user);
  Future<String> generateToken();
  Future<UserDto> updateUserData(UserDataEntity user);
}
