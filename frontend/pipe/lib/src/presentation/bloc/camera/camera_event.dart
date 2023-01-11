part of 'camera_bloc.dart';

abstract class CameraEvent extends Equatable {
  const CameraEvent();

  @override
  List<Object> get props => [];
}

class InitCameraEvent extends CameraEvent {
  final int cameraId;

  const InitCameraEvent(this.cameraId);
}

class CloseCameraEvent extends CameraEvent {}
