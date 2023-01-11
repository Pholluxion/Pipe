import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pipe/src/di.dart';
import 'package:pipe/src/presentation/routes.dart' as routes;

import '../../core/utils/colors.dart';
import '../../data/services/navigation_service.dart';
import '../bloc/actions/actions_bloc.dart';
import '../bloc/camera/camera_bloc.dart';
import '../bloc/microfone/microfone_cubit.dart';
import '../widgets/pipe_toast_widget.dart';

class NewMettingPage extends StatefulWidget {
  const NewMettingPage({super.key});
  @override
  State<NewMettingPage> createState() => _NewMettingPageState();
}

class _NewMettingPageState extends State<NewMettingPage> {
  @override
  void initState() {
    di<CameraBloc>().add(const InitCameraEvent(0));
    super.initState();
  }

  @override
  void dispose() {
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
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BlocBuilder<CameraBloc, CameraState>(
              builder: (context, state) {
                return FloatingActionButton(
                  heroTag: 'cameraswitch_sharp',
                  backgroundColor: PipeColor.kPipeGreen,
                  key: const Key('cameraswitch_sharp'),
                  onPressed: () {
                    if (state is LoadedCameraState) {
                      if (state.selectCamera.isEven) {
                        di<CameraBloc>().add(const InitCameraEvent(1));
                        di<ActionsBloc>().add(const HandleCameraIndexEvent(1));
                      } else {
                        di<CameraBloc>().add(const InitCameraEvent(0));
                        di<ActionsBloc>().add(const HandleCameraIndexEvent(0));
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
                  heroTag: 'videocam_off',
                  backgroundColor: PipeColor.kPipeGreen,
                  key: const Key('videocam_off'),
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
                  heroTag: 'mic_off',
                  backgroundColor: PipeColor.kPipeGreen,
                  key: const Key('mic_off'),
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
            BlocBuilder<ActionsBloc, ActionsState>(
              builder: (context, state) {
                return FloatingActionButton(
                  heroTag: 'create_room',
                  backgroundColor: PipeColor.kPipeWhite,
                  key: const Key('create_room'),
                  onPressed: () async {
                    di<ActionsBloc>().add(CreateRoomEvent());
                    di<NavigationService>().navigateTo(routes.kConferencePage);
                  },
                  child: Icon(
                    Icons.video_settings,
                    color: PipeColor.kPipeGreen,
                  ),
                );
              },
            )
          ],
        ),
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
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            child: CameraPreview(
              cameraController,
            ),
          ),
        ],
      ),
    );
  }
}
