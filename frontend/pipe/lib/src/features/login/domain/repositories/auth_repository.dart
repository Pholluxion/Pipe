import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<String> login(UserEntity user);
}
