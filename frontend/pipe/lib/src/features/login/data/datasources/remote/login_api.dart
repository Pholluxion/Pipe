import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../../domain/entities/user_entity.dart';

part 'login_api.g.dart';

@RestApi(baseUrl: "http://192.168.1.23:8080/api/auth")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("/login")
  Future<String> loginUser(@Body() UserEntity userEntity);
}
