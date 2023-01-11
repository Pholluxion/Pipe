part of 'camera_bloc.dart';

abstract class CameraState extends Equatable {
  const CameraState();

  @override
  List<Object> get props => [];
}

class CameraInitial extends CameraState {}

class LoadingCameraState extends CameraState {}

class LoadedCameraState extends CameraState {
  final int selectCamera;
  final CameraController cameraController;

  @override
  List<Object> get props => [cameraController];

  const LoadedCameraState(this.cameraController, this.selectCamera);
}

class ErrorCameraState extends CameraState {}
