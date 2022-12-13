part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.userResponseEntity,
    this.index = 0,
  });
  final UserResponseEntity? userResponseEntity;
  final int index;

  @override
  List<Object> get props => [index, userResponseEntity?.props ?? []];

  HomeState copyWith({
    UserResponseEntity? userResponseEntity,
    int? index,
  }) {
    return HomeState(
      index: index ?? this.index,
      userResponseEntity: userResponseEntity ?? this.userResponseEntity,
    );
  }
}
