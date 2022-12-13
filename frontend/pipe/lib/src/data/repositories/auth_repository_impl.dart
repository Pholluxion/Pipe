import '../../domain/entities/user_entity.dart';
import '../../domain/entities/user_response_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote/remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<String> register(UserEntity user) async {
    return await authRemoteDataSource.register(user);
  }

  @override
  Future<UserResponseEntity> login(UserEntity user) async {
    return await authRemoteDataSource.login(user);
  }
}
