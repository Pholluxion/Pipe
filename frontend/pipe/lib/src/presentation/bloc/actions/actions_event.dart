part of 'actions_bloc.dart';

abstract class ActionsEvent extends Equatable {
  const ActionsEvent();

  @override
  List<Object> get props => [];
}

class CreateRoomEvent extends ActionsEvent {}

class HandleRoomIdEvent extends ActionsEvent {
  final String roomId;

  const HandleRoomIdEvent(this.roomId);
}

class HandleTokenEvent extends ActionsEvent {
  final String token;

  const HandleTokenEvent(this.token);
}

class HandleDisplayNameEvent extends ActionsEvent {
  final String displayName;

  const HandleDisplayNameEvent(this.displayName);
}

class HandleMaxResolutionEvent extends ActionsEvent {
  final String maxResolution;

  const HandleMaxResolutionEvent(this.maxResolution);
}

class HandleMultiStreamEvent extends ActionsEvent {
  final bool multiStream;

  const HandleMultiStreamEvent(this.multiStream);
}

class HandleCameraIndexEvent extends ActionsEvent {
  final int defaultCameraIndex;

  const HandleCameraIndexEvent(this.defaultCameraIndex);
}

class HandleMicEnabledEvent extends ActionsEvent {}

class HandleCamEnabledEvent extends ActionsEvent {}

class HandleMicDisabledEvent extends ActionsEvent {}

class HandleCamDisabledEvent extends ActionsEvent {}
