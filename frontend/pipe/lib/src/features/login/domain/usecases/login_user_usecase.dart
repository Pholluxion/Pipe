import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginWithEmailAndPassword {
  final AuthRepository authRepository;

  LoginWithEmailAndPassword({required this.authRepository});

  Future<String> call(UserEntity user) async {
    return await authRepository.login(user);
  }
}
