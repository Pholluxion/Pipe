part of 'actions_bloc.dart';

class ActionsState extends Equatable {
  const ActionsState({
    this.token = '',
    this.roomId = '',
    this.displayName = '',
    this.micEnabled = false,
    this.camEnabled = false,
    this.multiStream = true,
    this.maxResolution = 'hd',
    this.defaultCameraIndex = 1,
  });

  final String roomId;
  final String token;
  final String displayName;
  final String maxResolution;
  final bool micEnabled;
  final bool camEnabled;
  final bool multiStream;
  final int defaultCameraIndex;

  ActionsState copyWith({
    String? roomId,
    String? token,
    String? displayName,
    String? maxResolution,
    bool? micEnabled,
    bool? camEnabled,
    bool? multiStream,
    int? defaultCameraIndex,
  }) =>
      ActionsState(
        camEnabled: camEnabled ?? this.camEnabled,
        roomId: roomId ?? this.roomId,
        token: token ?? this.token,
        displayName: displayName ?? this.displayName,
        maxResolution: maxResolution ?? this.maxResolution,
        micEnabled: micEnabled ?? this.micEnabled,
        multiStream: multiStream ?? this.multiStream,
        defaultCameraIndex: defaultCameraIndex ?? this.defaultCameraIndex,
      );

  @override
  List<Object?> get props => [
        roomId,
        token,
        displayName,
        maxResolution,
        micEnabled,
        camEnabled,
        multiStream,
        defaultCameraIndex,
      ];
}
