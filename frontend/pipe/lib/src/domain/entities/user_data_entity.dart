import 'package:equatable/equatable.dart';

abstract class UserDataEntity extends Equatable {
  final String? id;
  final String? name;
  final String? email;
  final String? cellPhone;
  final String? sex;
  final String? occupation;

  const UserDataEntity({
    this.id,
    this.name,
    this.email,
    this.cellPhone,
    this.sex,
    this.occupation,
  });

  @override
  List<Object?> get props => [
        id,
        email,
        cellPhone,
        email,
        name,
        occupation,
        sex,
      ];

  Map<String, dynamic> toJson();
}
