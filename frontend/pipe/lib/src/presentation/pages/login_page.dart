import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:pipe/src/data/services/navigation_service.dart';
import 'package:pipe/src/di.dart';
import 'package:pipe/src/presentation/routes.dart' as routes;

import '../../core/utils/colors.dart';
import '../bloc/login/login_cubit.dart';
import '../widgets/widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Hero(
      tag: 'init',
      child: Scaffold(
        backgroundColor: PipeColor.kPipeBlack,
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.1),
            child: BlocListener<LogInCubit, LogInState>(
              listener: (context, state) {
                if (state.status.isSubmissionSuccess) {
                  di<NavigationService>().popAndNavigateTo(routes.kHomeRoute);
                } else if (state.status.isSubmissionFailure) {
                  _showErrorDialog(context);
                }
              },
              child: Column(
                children: const [
                  PipeLogoTipo(h: 150.0),
                  _LoginMessage(),
                  HelpBtn(),
                  _EmailTextFieldWidget(),
                  _PasswordTextFieldWidget(),
                  _RecoveryPasswordBtn(),
                  _LogInBtn(),
                  PipeDivider(),
                  _RegisterBtn()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> _showErrorDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('¡Ocurrio un error!'),
        content:
            const Text('Por favor verifica tus datos e intenta nuevamente.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => di<NavigationService>().goBack(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class _LogInBtn extends StatelessWidget {
  const _LogInBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogInCubit, LogInState>(
      builder: (context, state) {
        if (state.status == FormzStatus.submissionInProgress) {
          return GreenBigButton(
            loading: true,
            label: 'Iniciar sesión',
            onPressed: () => context.read<LogInCubit>().logInFormSubmitted(),
          );
        } else {
          return GreenBigButton(
            loading: false,
            label: 'Iniciar sesión',
            onPressed: () => context.read<LogInCubit>().logInFormSubmitted(),
          );
        }
      },
    );
  }
}

class _RegisterBtn extends StatelessWidget {
  const _RegisterBtn();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 350.0),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            "No estas registrado?",
            style: TextStyle(
              color: PipeColor.kPipeWhite,
            ),
          ),
          TextButton(
            onPressed: () {
              di<NavigationService>().navigateTo(routes.kRegisterRoute);
            },
            child: const Text(" Registrate ahora"),
          )
        ],
      ),
    );
  }
}

class _RecoveryPasswordBtn extends StatelessWidget {
  const _RecoveryPasswordBtn();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 350.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "Recuperar contraseña",
                textAlign: TextAlign.right,
                style: TextStyle(color: PipeColor.kPipeGreen),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginMessage extends StatelessWidget {
  const _LoginMessage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        "Iniciar sesión",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: PipeColor.kPipeWhite,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
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
    return BlocBuilder<LogInCubit, LogInState>(
      builder: (context, state) {
        return EmailTextField(
          email: state.email.value,
          errorText: state.email,
          onChanged: (email) => context.read<LogInCubit>().emailChanged(email),
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
    return BlocBuilder<LogInCubit, LogInState>(
      builder: (context, state) {
        return PasswordTextField(
          password: state.password.value,
          errorText: state.password,
          onChanged: (password) =>
              context.read<LogInCubit>().passwordChanged(password),
        );
      },
    );
  }
}
