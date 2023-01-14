import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pipe/src/di.dart';
import 'package:pipe/src/presentation/routes.dart' as routes;

import '../../core/utils/colors.dart';
import '../../data/datasources/remote/video_sdk_api.dart';
import '../../data/services/navigation_service.dart';
import '../bloc/actions/actions_bloc.dart';
import '../bloc/camera/camera_bloc.dart';
import '../bloc/microfone/microfone_cubit.dart';
import '../widgets/pipe_toast_widget.dart';
import '../widgets/textfield/pipe_textfield.dart';

class JoinPage extends StatefulWidget {
  const JoinPage({super.key});
  @override
  State<JoinPage> createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  final TextEditingController _controller = TextEditingController();
  final ValueNotifier<bool> _isOkRoom = ValueNotifier(false);

  @override
  void initState() {
    log('JOIN PAGE');
    di<CameraBloc>().add(CloseCameraEvent());
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _isOkRoom.dispose();
    di<CameraBloc>().add(CloseCameraEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: PipeColor.kPipeBlack,
        body: BlocBuilder<CameraBloc, CameraState>(
          builder: (context, state) {
            if (state is LoadedCameraState) {
              return _VideoWidget(
                cameraController: state.cameraController,
              );
            } else if (state is LoadingCameraState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CameraInitial) {
              return Center(
                child: Icon(
                  Icons.videocam_off,
                  color: PipeColor.kPipeGreen,
                  size: 150.0,
                ),
              );
            } else {
              return const Center(
                child: Text('Ocurrio un problema :('),
              );
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Flexible(
                child: PipeTextField(
                  hintText: 'Código de la sala',
                  value: _controller.text,
                  onChanged: (p0) {
                    di<ActionsBloc>().add(
                      HandleRoomIdEvent(p0.trim()),
                    );
                    _controller.text = p0.trim();
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BlocBuilder<CameraBloc, CameraState>(
                  builder: (context, state) {
                    return FloatingActionButton(
                      heroTag: 'join_cameraswitch_sharp',
                      backgroundColor: PipeColor.kPipeGreen,
                      key: const Key('join_cameraswitch_sharp'),
                      onPressed: () {
                        if (state is LoadedCameraState) {
                          if (state.selectCamera.isEven) {
                            di<CameraBloc>().add(const InitCameraEvent(1));
                            di<ActionsBloc>()
                                .add(const HandleCameraIndexEvent(1));
                          } else {
                            di<CameraBloc>().add(const InitCameraEvent(0));
                            di<ActionsBloc>()
                                .add(const HandleCameraIndexEvent(0));
                          }
                        }
                      },
                      child: const Icon(
                        Icons.cameraswitch_sharp,
                      ),
                    );
                  },
                ),
                BlocBuilder<CameraBloc, CameraState>(
                  builder: (context, state) {
                    return FloatingActionButton(
                      heroTag: 'join_videocam_off',
                      backgroundColor: PipeColor.kPipeGreen,
                      key: const Key('join_videocam_off'),
                      onPressed: () {
                        if (state is CameraInitial) {
                          showSnackBarMessage(
                            context: context,
                            message: 'Camara abierta',
                          );
                          di<CameraBloc>().add(const InitCameraEvent(0));
                          di<ActionsBloc>().add(HandleCamEnabledEvent());
                        } else {
                          showSnackBarMessage(
                            context: context,
                            message: 'Camara cerrada',
                          );
                          di<CameraBloc>().add(CloseCameraEvent());
                          di<ActionsBloc>().add(HandleCamDisabledEvent());
                        }
                      },
                      child: Icon(
                        state is CameraInitial
                            ? Icons.videocam_off
                            : Icons.videocam,
                      ),
                    );
                  },
                ),
                BlocBuilder<MicrofoneCubit, bool>(
                  builder: (context, state) {
                    return FloatingActionButton(
                      heroTag: 'join_mic_off',
                      backgroundColor: PipeColor.kPipeGreen,
                      key: const Key('join_mic_off'),
                      onPressed: () {
                        if (state) {
                          showSnackBarMessage(
                            context: context,
                            message: 'Micrófono cerrado',
                          );
                          di<MicrofoneCubit>().disableMicrofone();
                          di<ActionsBloc>().add(HandleMicDisabledEvent());
                        } else {
                          showSnackBarMessage(
                            context: context,
                            message: 'Micrófono abierto',
                          );
                          di<MicrofoneCubit>().enableMicrofone();
                          di<ActionsBloc>().add(HandleMicEnabledEvent());
                        }
                      },
                      child: Icon(
                        !state ? Icons.mic_off : Icons.mic,
                      ),
                    );
                  },
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: _isOkRoom,
                  builder: (ctx, value, child) {
                    return value
                        ? const CircularProgressIndicator.adaptive()
                        : BlocBuilder<ActionsBloc, ActionsState>(
                            builder: (context, state) {
                              return FloatingActionButton(
                                heroTag: 'join_metting_room',
                                backgroundColor: PipeColor.kPipeWhite,
                                key: const Key('join_metting_room'),
                                onPressed: () async {
                                  _isOkRoom.value = true;
                                  try {
                                    await validateMeeting(
                                            di<ActionsBloc>().state.token,
                                            di<ActionsBloc>().state.roomId)
                                        .then((value) {
                                      if (value) {
                                        di<NavigationService>()
                                            .navigateTo(routes.kConferencePage);
                                      }
                                    });
                                  } catch (e) {
                                    _showErrorDialog(ctx);
                                  }
                                  Future.delayed(const Duration(seconds: 2))
                                      .then((value) => _isOkRoom.value = false);
                                },
                                child: Icon(
                                  Icons.door_front_door_outlined,
                                  color: PipeColor.kPipeGreen,
                                ),
                              );
                            },
                          );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> _showErrorDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('¡Ocurrio un error!'),
        content: const Text('Por favor verifica el ID de la sala.'),
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

class _VideoWidget extends StatelessWidget {
  const _VideoWidget({
    Key? key,
    required this.cameraController,
  }) : super(key: key);

  final CameraController cameraController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Flexible(
          child: CameraPreview(
            cameraController,
          ),
        ),
      ),
    );
  }
}
