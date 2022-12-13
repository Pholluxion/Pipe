import 'package:equatable/equatable.dart';

import 'user_data_entity.dart';

class UserResponseEntity extends Equatable {
  final int? status;
  final String? message;
  final UserDataEntity? userDto;

  const UserResponseEntity({
    this.status,
    this.message,
    this.userDto,
  });

  @override
  List<Object?> get props => [
        message,
        status,
        userDto,
      ];
}
