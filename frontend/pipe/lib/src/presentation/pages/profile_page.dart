import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pipe/src/data/models/user_data_model.dart';

import '../../core/utils/colors.dart';
import '../bloc/home/home_cubit.dart';
import '../widgets/pipe_toast_widget.dart';
import '../widgets/widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cellPhoneController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: PipeColor.kPipeBlack,
      appBar: PipeAppBar(size: size),
      body: SingleChildScrollView(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: PipeColor.kPipeGreen,
                      maxRadius: 70.0,
                      minRadius: 50.0,
                      child: FittedBox(
                        child: Text(
                          state.userResponseEntity?.userDto?.name
                                  ?.split(' ')[0] ??
                              '',
                          style: TextStyle(
                            color: PipeColor.kPipeWhite,
                            fontSize: 30.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  PipeTextField(
                    value: state.userResponseEntity?.userDto?.name,
                    hintText: 'Nombre',
                    onChanged: (p0) {
                      UserDto userDto = UserDto(
                        email: state.userResponseEntity?.userDto?.email,
                        name: p0,
                        cellPhone: state.userResponseEntity?.userDto?.cellPhone,
                        occupation:
                            state.userResponseEntity?.userDto?.occupation,
                        sex: state.userResponseEntity?.userDto?.sex,
                      );

                      context.read<HomeCubit>().updateUserDto(userDto);
                    },
                  ),
                  PipeTextField(
                    value: state.userResponseEntity?.userDto?.email,
                    hintText: 'Correo electrónico',
                    isEnable: false,
                    onChanged: (p0) {},
                  ),
                  PipeTextField(
                    value: state.userResponseEntity?.userDto?.cellPhone,
                    hintText: 'Número de teléfono',
                    onChanged: (p0) {
                      UserDto userDto = UserDto(
                        email: state.userResponseEntity?.userDto?.email,
                        name: state.userResponseEntity?.userDto?.name,
                        cellPhone: p0,
                        occupation:
                            state.userResponseEntity?.userDto?.occupation,
                        sex: state.userResponseEntity?.userDto?.sex,
                      );

                      context.read<HomeCubit>().updateUserDto(userDto);
                    },
                  ),
                  PipeTextField(
                    value: state.userResponseEntity?.userDto?.occupation,
                    hintText: 'Ocupación',
                    onChanged: (p0) {
                      UserDto userDto = UserDto(
                        email: state.userResponseEntity?.userDto?.email,
                        name: state.userResponseEntity?.userDto?.name,
                        cellPhone: state.userResponseEntity?.userDto?.cellPhone,
                        occupation: p0,
                        sex: state.userResponseEntity?.userDto?.sex,
                      );

                      context.read<HomeCubit>().updateUserDto(userDto);
                    },
                  ),
                  GreenBigButton(
                    onPressed: () {
                      context.read<HomeCubit>().updateUserData().then(
                            (value) => showSnackBarMessage(
                              context: context,
                              message: '¡Datos actualizados!',
                            ),
                          );
                    },
                    label: 'Actualizar Datos',
                  )
                ],
              ),
            );
          },
        ),
      ),
      drawer: orientation == Orientation.landscape ? const PipeDrawer() : null,
      bottomNavigationBar:
          orientation == Orientation.portrait ? const PipeNavBar() : null,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cellPhoneController.dispose();
    _occupationController.dispose();
    super.dispose();
  }
}
