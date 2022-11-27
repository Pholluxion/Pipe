import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../features/signup/data/datasources/remote/remote_datasource.dart';
import '../features/signup/data/repositories/auth_repository_impl.dart';
import '../features/signup/domain/repositories/auth_repository.dart';
import '../features/signup/domain/usecases/register_user_usecase.dart';

final di = GetIt.instance;

void init() {
  di.registerFactory<RegisterWithEmailAndPassword>(
      () => RegisterWithEmailAndPassword(authRepository: di()));

  di.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authRemoteDataSource: di()));

  di.registerLazySingleton<RemoteDataSource>(
      () => AuthRemoteDataSource(dio: di()));

  di.registerLazySingleton(() => Dio());
}
