import 'package:pipe/src/core/env.dart';
import 'package:pipe/src/domain/entities/user_data_entity.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../models/user_data_model.dart';

part 'userdata_api.g.dart';

@RestApi(baseUrl: "http://$kIpConfig/api/userdata")
abstract class UserDataAPi {
  factory UserDataAPi(Dio dio, {String baseUrl}) = _UserDataAPi;

  @PUT("/update")
  Future<UserDto> updateUser(@Body() UserDataEntity userEntity);
}
