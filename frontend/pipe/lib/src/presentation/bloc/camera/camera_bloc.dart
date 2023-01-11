import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'camera_event.dart';
part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraBloc() : super(CameraInitial()) {
    on<InitCameraEvent>(_initCameraEvent);
    on<CloseCameraEvent>(_closeCameraEvent);
  }

  Future<void> _initCameraEvent(
      InitCameraEvent event, Emitter<CameraState> emit) async {
    CameraController cameraController;

    emit(LoadingCameraState());

    try {
      final listCameras = await availableCameras();

      if (event.cameraId > 0 && listCameras.length == 1) {
        return;
      }

      cameraController = CameraController(
        listCameras[event.cameraId],
        ResolutionPreset.ultraHigh,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );
      await cameraController.initialize().then((_) {});

      emit(LoadedCameraState(cameraController, event.cameraId));
    } catch (e) {
      emit(ErrorCameraState());
    }
  }

  void _closeCameraEvent(CloseCameraEvent event, Emitter<CameraState> emit) {
    final currentState = state;
    if (currentState is LoadedCameraState) {
      currentState.cameraController.dispose();
      emit(CameraInitial());
    }
  }
}
