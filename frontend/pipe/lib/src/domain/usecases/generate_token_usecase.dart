import '../repositories/auth_repository.dart';

class GenerateToken {
  final AuthRepository authRepository;

  GenerateToken({required this.authRepository});

  Future<String> call() async {
    return await authRepository.generateToken();
  }
}
