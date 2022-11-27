import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterWithEmailAndPassword {
  final AuthRepository authRepository;

  RegisterWithEmailAndPassword({required this.authRepository});

  Future<String> call(UserEntity user) async {
    return await authRepository.register(user);
  }
}
