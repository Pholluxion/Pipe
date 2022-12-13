import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../core/settings/settings_controller.dart';
import '../../../core/utils/validations/email_validation.dart';
import '../../../core/utils/validations/password_validation.dart';
import '../../../data/models/user_model.dart';
import '../../../di.dart';
import '../../../domain/entities/user_response_entity.dart';
import '../../../domain/usecases/login_user_usecase.dart';
import '../home/home_cubit.dart';

part 'login_state.dart';

class LogInCubit extends Cubit<LogInState> {
  LogInCubit(this.homeCubit) : super(const LogInState());

  final HomeCubit homeCubit;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([
          email,
          state.password,
        ]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);

    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([
          state.email,
          password,
        ]),
      ),
    );
  }

  Future<void> logInFormSubmitted() async {
    // if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      final response = await di.get<LoginWithEmailAndPassword>().call(
            UserModel(
              username: '',
              email: state.email.value,
              password: state.password.value,
            ),
          );
      emit(
        state.copyWith(
          status: FormzStatus.submissionSuccess,
          username: response.toString(),
          userResponseEntity: response,
        ),
      );
      homeCubit.loadUser(response);
      settingsController.saveUser(json.encode(response));
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  Future<void> logOutFormSubmitted() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      settingsController.deleteUser();

      emit(
        state.copyWith(
          status: FormzStatus.submissionSuccess,
          username: '',
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}