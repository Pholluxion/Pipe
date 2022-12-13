// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDataModel _$UserDataModelFromJson(Map<String, dynamic> json) =>
    UserDataModel(
      status: json['status'] as int?,
      message: json['message'] as String?,
      userDto: json['userDto'] == null
          ? null
          : UserDto.fromJson(json['userDto'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserDataModelToJson(UserDataModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'userDto': instance.userDto,
    };

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      cellPhone: json['cellPhone'] as String?,
      sex: json['sex'] as String?,
      occupation: json['occupation'] as String?,
    );

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'cellPhone': instance.cellPhone,
      'sex': instance.sex,
      'occupation': instance.occupation,
    };
