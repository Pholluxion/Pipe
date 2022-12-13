import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../../core/exceptions/user_not_found_ex.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/entities/user_response_entity.dart';
import 'auth_api.dart';

abstract class RemoteDataSource {
  Future<String> register(UserEntity user);
  Future<UserResponseEntity> login(UserEntity user);
}

class AuthRemoteDataSource implements RemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource({required this.dio});

  @override
  Future<String> register(UserEntity user) {
    try {
      final client = RestClient(dio);
      final data = client.registerUser(user).then((value) {
        Logger().i(value);
        return "$value then";
      }).catchError((Object obj) {
        switch (obj.runtimeType) {
          case DioError:
            final res = (obj as DioError).response;
            Logger().e("Got error : ${res?.statusCode}");
            throw UserNotFound(
                statusCode: res?.statusCode, statusMessage: res?.statusMessage);
          default:
            break;
        }
      });
      return data;
    } catch (_) {
      throw Exception("Ocurrio un problema");
    }
  }

  @override
  Future<UserResponseEntity> login(UserEntity user) async {
    try {
      final client = RestClient(dio);
      return await client.loginUser(user);
    } catch (e) {
      throw Exception("Ocurrio un problema");
    }
  }
}
