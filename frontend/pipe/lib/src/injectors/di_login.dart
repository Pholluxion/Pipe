import 'package:get_it/get_it.dart';

import '../features/login/data/datasources/remote/remote_datasource.dart';
import '../features/login/data/repositories/auth_repository_impl.dart';
import '../features/login/domain/repositories/auth_repository.dart';
import '../features/login/domain/usecases/login_user_usecase.dart';

final di = GetIt.instance;

void init() {
  di.registerFactory<LoginWithEmailAndPassword>(
      () => LoginWithEmailAndPassword(authRepository: di()));

  di.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authRemoteDataSource: di()));

  di.registerLazySingleton<RemoteDataSource>(
      () => AuthRemoteDataSource(dio: di()));
}
