import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'data/datasources/remote/remote_datasource.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/login_user_usecase.dart';
import 'domain/usecases/register_user_usecase.dart';

final di = GetIt.instance;

void init() {
  di.registerFactory<LoginWithEmailAndPassword>(
      () => LoginWithEmailAndPassword(authRepository: di()));

  di.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authRemoteDataSource: di()));

  di.registerLazySingleton<RemoteDataSource>(
      () => AuthRemoteDataSource(dio: di()));

  di.registerFactory<RegisterWithEmailAndPassword>(
      () => RegisterWithEmailAndPassword(authRepository: di()));

  di.registerLazySingleton(() => Dio());
}
