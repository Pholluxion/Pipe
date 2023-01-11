import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:pipe/src/di.dart';
import 'package:pipe/src/presentation/routes.dart' as routes;

import '../../core/utils/colors.dart';
import '../../data/services/navigation_service.dart';
import '../bloc/signup/signup_cubit.dart';
import '../widgets/widget.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Hero(
      tag: 'init',
      child: SafeArea(
        child: Scaffold(
          backgroundColor: PipeColor.kPipeBlack,
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.1),
              child: BlocConsumer<SignUpCubit, SignUpState>(
                listener: (context, state) {
                  if (state.status.isSubmissionSuccess) {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('¡Registro exitoso!'),
                        content: const Text('Ya puedes iniciar sesión'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => di<NavigationService>()
                                .popAndNavigateTo(routes.kLoginRoute),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  } else if (state.status.isSubmissionFailure) {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('¡Ocurrio un error!'),
                        content: const Text(
                            'Por favor verifica tus datos e intenta nuevamente.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => di<NavigationService>().goBack(),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state.status.isSubmissionInProgress) {
                    return SizedBox(
                      height: size.height,
                      width: size.width,
                      child: const Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    );
                  } else {
                    return Column(
                      children: const [
                        PipeLogoTipo(h: 100.0),
                        _RegisterMessage(),
                        HelpBtn(),
                        _UsernameTextFieldWidget(),
                        _EmailTextFieldWidget(),
                        _PasswordTextFieldWidget(),
                        _ConfirmPasswordTextFieldWidget(),
                        _RegisterUserBtn(),
                        PipeDivider(),
                        _RegisterBtn()
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailTextFieldWidget extends StatelessWidget {
  const _EmailTextFieldWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return EmailTextField(
          errorText: state.email,
          onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
        );
      },
    );
  }
}

class _PasswordTextFieldWidget extends StatelessWidget {
  const _PasswordTextFieldWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return PasswordTextField(
          errorText: state.password,
          onChanged: (password) =>
              context.read<SignUpCubit>().passwordChanged(password),
        );
      },
    );
  }
}

class _ConfirmPasswordTextFieldWidget extends StatelessWidget {
  const _ConfirmPasswordTextFieldWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return ConfirmPasswordTextField(
          errorText: state.confirmedPassword,
          onChanged: (password) =>
              context.read<SignUpCubit>().confirmedPasswordChanged(password),
        );
      },
    );
  }
}

class _UsernameTextFieldWidget extends StatelessWidget {
  const _UsernameTextFieldWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return PipeTextField(
          onChanged: (username) =>
              context.read<SignUpCubit>().usernameChanged(username),
        );
      },
    );
  }
}

class _RegisterUserBtn extends StatelessWidget {
  const _RegisterUserBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GreenBigButton(
      onPressed: () => context.read<SignUpCubit>().signUpFormSubmitted(),
      label: 'Crear cuenta',
    );
  }
}

class _RegisterBtn extends StatelessWidget {
  const _RegisterBtn();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Ya tienes una cuenta?",
          style: TextStyle(
            color: PipeColor.kPipeWhite,
          ),
        ),
        TextButton(
          onPressed: () =>
              di<NavigationService>().popAndNavigateTo(routes.kLoginRoute),
          child: const Text(" Inicia sesión"),
        ),
      ],
    );
  }
}

class _RegisterMessage extends StatelessWidget {
  const _RegisterMessage();

  @override
  Widget build(BuildContext context) {
    return Text(
      "Registro",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: PipeColor.kPipeWhite,
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
