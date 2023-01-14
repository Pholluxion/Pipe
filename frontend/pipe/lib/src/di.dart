import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'data/datasources/remote/remote_datasource.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'data/services/navigation_service.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/generate_token_usecase.dart';
import 'domain/usecases/login_user_usecase.dart';
import 'domain/usecases/register_user_usecase.dart';
import 'domain/usecases/update_userdata_usecase.dart';
import 'presentation/bloc/actions/actions_bloc.dart';
import 'presentation/bloc/camera/camera_bloc.dart';
import 'presentation/bloc/home/home_cubit.dart';
import 'presentation/bloc/login/login_cubit.dart';
import 'presentation/bloc/microfone/microfone_cubit.dart';
import 'presentation/bloc/signup/signup_cubit.dart';
import 'presentation/bloc/video/video_sdk_bloc.dart';

final di = GetIt.instance;

void init() {
  di.registerLazySingleton<HomeCubit>(() => HomeCubit());
  di.registerLazySingleton<CameraBloc>(() => CameraBloc());
  di.registerLazySingleton<ActionsBloc>(() => ActionsBloc());
  di.registerLazySingleton<SignUpCubit>(() => SignUpCubit());
  di.registerLazySingleton<MicrofoneCubit>(() => MicrofoneCubit());
  di.registerLazySingleton<VideoSdkBloc>(() => VideoSdkBloc());
  di.registerLazySingleton<LogInCubit>(() => LogInCubit(homeCubit: di()));

  di.registerFactory<LoginWithEmailAndPassword>(
    () => LoginWithEmailAndPassword(authRepository: di()),
  );

  di.registerFactory<GenerateToken>(
    () => GenerateToken(authRepository: di()),
  );

  di.registerFactory<UpdateUserData>(
    () => UpdateUserData(authRepository: di()),
  );

  di.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authRemoteDataSource: di()),
  );

  di.registerLazySingleton<RemoteDataSource>(
      () => AuthRemoteDataSource(dio: di()));

  di.registerFactory<RegisterWithEmailAndPassword>(
    () => RegisterWithEmailAndPassword(authRepository: di()),
  );

  di.registerLazySingleton(() => Dio());

  di.registerLazySingleton(() => NavigationService());
}
