import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/datasources/remote/video_sdk_api.dart';

part 'actions_event.dart';
part 'actions_state.dart';

class ActionsBloc extends Bloc<ActionsEvent, ActionsState> {
  ActionsBloc() : super(const ActionsState()) {
    on<CreateRoomEvent>(_createRoomEvent);
    on<HandleTokenEvent>(_handleTokenEvent);
    on<HandleRoomIdEvent>(_handleRoomIdEvent);
    on<HandleMicEnabledEvent>(_handleMicEnabledEvent);
    on<HandleCamEnabledEvent>(_handleCamEnabledEvent);
    on<HandleMicDisabledEvent>(_handleMicDisabledEvent);
    on<HandleCamDisabledEvent>(_handleCamDisabledEvent);
    on<HandleCameraIndexEvent>(_handleCameraIndexEvent);
    on<HandleMultiStreamEvent>(_handleMultiStreamEvent);
    on<HandleDisplayNameEvent>(_handleDisplayNameEvent);
    on<HandleMaxResolutionEvent>(_handleMaxResolutionEvent);
  }

  void _handleTokenEvent(
    HandleTokenEvent event,
    Emitter<ActionsState> emit,
  ) =>
      emit(state.copyWith(
        token: event.token,
      ));

  void _handleRoomIdEvent(
    HandleRoomIdEvent event,
    Emitter<ActionsState> emit,
  ) =>
      emit(state.copyWith(
        roomId: event.roomId,
      ));

  Future<void> _createRoomEvent(
    CreateRoomEvent event,
    Emitter<ActionsState> emit,
  ) async {
    try {
      await createMeeting(state.token).then(
        (value) => emit(
          state.copyWith(roomId: value),
        ),
      );
    } catch (_) {}
  }

  void _handleMicEnabledEvent(
    HandleMicEnabledEvent event,
    Emitter<ActionsState> emit,
  ) =>
      emit(state.copyWith(
        micEnabled: true,
      ));

  void _handleMicDisabledEvent(
    HandleMicDisabledEvent event,
    Emitter<ActionsState> emit,
  ) =>
      emit(state.copyWith(
        micEnabled: false,
      ));

  void _handleCamEnabledEvent(
    HandleCamEnabledEvent event,
    Emitter<ActionsState> emit,
  ) =>
      emit(state.copyWith(
        camEnabled: true,
      ));

  void _handleCamDisabledEvent(
    HandleCamDisabledEvent event,
    Emitter<ActionsState> emit,
  ) =>
      emit(state.copyWith(
        camEnabled: false,
      ));

  void _handleCameraIndexEvent(
    HandleCameraIndexEvent event,
    Emitter<ActionsState> emit,
  ) =>
      emit(state.copyWith(
        defaultCameraIndex: event.defaultCameraIndex,
      ));

  void _handleMultiStreamEvent(
    HandleMultiStreamEvent event,
    Emitter<ActionsState> emit,
  ) =>
      emit(state.copyWith(
        multiStream: event.multiStream,
      ));

  void _handleDisplayNameEvent(
    HandleDisplayNameEvent event,
    Emitter<ActionsState> emit,
  ) =>
      emit(state.copyWith(
        displayName: event.displayName,
      ));

  void _handleMaxResolutionEvent(
    HandleMaxResolutionEvent event,
    Emitter<ActionsState> emit,
  ) =>
      emit(state.copyWith(
        maxResolution: event.maxResolution,
      ));
}
