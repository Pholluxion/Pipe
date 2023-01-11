part of 'video_sdk_bloc.dart';

abstract class VideoSdkEvent extends Equatable {
  const VideoSdkEvent();

  @override
  List<Object> get props => [];
}

class GetRoomsEvent extends VideoSdkEvent {
  final String token;

  const GetRoomsEvent(this.token);
}

class CreateRoomEvent extends VideoSdkEvent {
  final String token;

  const CreateRoomEvent(this.token);
}
