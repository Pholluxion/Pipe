import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? username;
  final String email;
  final String password;

  const UserEntity({
    this.username,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [
        username,
        email,
        password,
      ];
}
