part of 'login_cubit.dart';

class LogInState extends Equatable {
  const LogInState({
    this.username = '',
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  final Email email;
  final Password password;
  final FormzStatus status;
  final String? errorMessage;
  final String username;

  @override
  List<Object> get props => [
        email,
        password,
        status,
        username,
      ];

  LogInState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
    String? errorMessage,
    String? username,
  }) {
    return LogInState(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
