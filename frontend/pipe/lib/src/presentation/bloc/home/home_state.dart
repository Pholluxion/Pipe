part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.userResponseEntity,
    this.index = 0,
    this.token = '',
  });
  final UserResponseEntity? userResponseEntity;
  final int index;
  final String token;

  @override
  List<Object> get props => [index, userResponseEntity?.props ?? []];

  HomeState copyWith({
    UserResponseEntity? userResponseEntity,
    int? index,
    String? token,
  }) {
    return HomeState(
      token: token ?? this.token,
      index: index ?? this.index,
      userResponseEntity: userResponseEntity ?? this.userResponseEntity,
    );
  }
}
