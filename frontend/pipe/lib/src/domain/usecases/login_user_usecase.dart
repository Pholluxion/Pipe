import '../entities/user_entity.dart';
import '../entities/user_response_entity.dart';
import '../repositories/auth_repository.dart';

class LoginWithEmailAndPassword {
  final AuthRepository authRepository;

  LoginWithEmailAndPassword({required this.authRepository});

  Future<UserResponseEntity> call(UserEntity user) async {
    return await authRepository.login(user);
  }
}
