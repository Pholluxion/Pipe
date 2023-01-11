import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/user_data_entity.dart';
import '../../domain/entities/user_response_entity.dart';

part 'user_data_model.g.dart';

@JsonSerializable()
class UserDataModel extends UserResponseEntity {
  const UserDataModel({
    int? status,
    String? message,
    String? token,
    UserDto? userDto,
  }) : super(
          message: message,
          status: status,
          userDto: userDto,
        );

  factory UserDataModel.fromJson(Map<String, Object?> json) =>
      _$UserDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataModelToJson(this);
}

@JsonSerializable()
class UserDto extends UserDataEntity {
  const UserDto({
    String? id,
    String? name,
    String? email,
    String? cellPhone,
    String? sex,
    String? occupation,
  }) : super(
          id: id,
          cellPhone: cellPhone,
          email: email,
          name: name,
          occupation: occupation,
          sex: sex,
        );

  factory UserDto.fromJson(Map<String, Object?> json) =>
      _$UserDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
