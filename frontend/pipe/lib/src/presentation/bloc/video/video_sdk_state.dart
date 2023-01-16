part of 'video_sdk_bloc.dart';

abstract class VideoSdkState extends Equatable {
  const VideoSdkState();

  @override
  List<Object> get props => [];
}

class VideoSdkInitial extends VideoSdkState {}

class LoadingRoomsState extends VideoSdkState {}

class LoadedRoomsState extends VideoSdkState {
  final List<dynamic> rooms;

  @override
  List<Object> get props => [rooms];

  const LoadedRoomsState(this.rooms);
}

class ErrorRoomsState extends VideoSdkState {}
