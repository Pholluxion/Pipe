import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pipe/src/data/datasources/remote/video_sdk_api.dart';

part 'video_sdk_event.dart';
part 'video_sdk_state.dart';

class VideoSdkBloc extends Bloc<VideoSdkEvent, VideoSdkState> {
  VideoSdkBloc() : super(VideoSdkInitial()) {
    on<GetRoomsEvent>(_loadRoomsEvent);
    on<CreateRoomEvent>(_createRoomEvent);
  }

  void _loadRoomsEvent(GetRoomsEvent event, Emitter emit) async {
    try {
      emit(LoadingRoomsState());
      await getRooms(event.token).then(
        (rooms) {
          final stateNow = state;
          if (stateNow is LoadedRoomsState) {
            final roomsNow = stateNow.rooms;

            emit(LoadedRoomsState([roomsNow, ...rooms]));
          } else {
            emit(LoadedRoomsState(rooms));
          }
        },
      );
    } catch (ex) {
      emit(ErrorRoomsState());
    }
  }

  void _createRoomEvent(
      CreateRoomEvent event, Emitter<VideoSdkState> emit) async {
    try {
      await createMeeting(event.token);
    } catch (ex) {
      emit(ErrorRoomsState());
    }
  }
}
