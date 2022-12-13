import 'package:pipe/src/core/env.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../../domain/entities/user_entity.dart';
import '../../models/user_data_model.dart';

part 'auth_api.g.dart';

@RestApi(baseUrl: "http://$kIpConfig:8081/api/auth")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("/register")
  Future<String> registerUser(@Body() UserEntity userEntity);

  @POST("/login")
  Future<UserDataModel> loginUser(@Body() UserEntity loginUserEntity);
}
