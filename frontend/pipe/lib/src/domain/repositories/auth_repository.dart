import '../entities/user_entity.dart';
import '../entities/user_response_entity.dart';

abstract class AuthRepository {
  Future<String> register(UserEntity user);
  Future<UserResponseEntity> login(UserEntity user);
  Future<String> generateToken();
}
