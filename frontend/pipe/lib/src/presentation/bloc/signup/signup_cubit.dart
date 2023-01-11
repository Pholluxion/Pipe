import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../core/utils/validations/email_validation.dart';
import '../../../core/utils/validations/password_confirm_validation.dart';
import '../../../core/utils/validations/password_validation.dart';
import '../../../data/models/user_model.dart';
import '../../../di.dart';
import '../../../domain/usecases/register_user_usecase.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(const SignUpState());

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([
          email,
          state.password,
          state.confirmedPassword,
        ]),
      ),
    );
  }

  void usernameChanged(String value) {
    emit(
      state.copyWith(
        username: value,
        status: Formz.validate([
          state.email,
          state.password,
          state.confirmedPassword,
        ]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final confirmedPassword = ConfirmedPassword.dirty(
      password: password.value,
      value: state.confirmedPassword.value,
    );
    emit(
      state.copyWith(
        password: password,
        confirmedPassword: confirmedPassword,
        status: Formz.validate([
          state.email,
          password,
          confirmedPassword,
        ]),
      ),
    );
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );
    emit(
      state.copyWith(
        confirmedPassword: confirmedPassword,
        status: Formz.validate([
          state.email,
          state.password,
          confirmedPassword,
        ]),
      ),
    );
  }

  Future<void> signUpFormSubmitted() async {
    if (state.confirmedPassword.value.isEmpty) {
      emit(state.copyWith(status: FormzStatus.invalid));
    }
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    try {
      final response = await di.get<RegisterWithEmailAndPassword>().call(
            UserModel(
              username: state.username,
              email: state.email.value,
              password: state.password.value,
            ),
          );
      emit(
        state.copyWith(
          status: FormzStatus.submissionSuccess,
          errorMessage: response,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
