import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<String> register(UserEntity user);
}
