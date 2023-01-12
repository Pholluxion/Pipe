import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pipe/src/core/utils/colors.dart';
import 'package:pipe/src/di.dart';
import 'package:pipe/src/presentation/pages/loading_page.dart';
import 'package:videosdk/videosdk.dart';

import '../bloc/actions/actions_bloc.dart';
import '../widgets/pipe_toast_widget.dart';
import 'conference_participant_grid.dart';

class ConfereneceMeetingScreen extends StatefulWidget {
  const ConfereneceMeetingScreen({Key? key}) : super(key: key);

  @override
  State<ConfereneceMeetingScreen> createState() =>
      _ConfereneceMeetingScreenState();
}

class _ConfereneceMeetingScreenState extends State<ConfereneceMeetingScreen> {
  bool isRecordingOn = false;
  bool showChatSnackbar = true;
  String recordingState = "RECORDING_STOPPED";
  // Meeting
  late Room meeting;
  bool _joined = false;

  // Streams
  Stream? shareStream;
  Stream? videoStream;
  Stream? audioStream;
  Stream? remoteParticipantShareStream;

  bool fullScreen = false;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // Create instance of Room (Meeting)
    Room room = VideoSDK.createRoom(
      roomId: di<ActionsBloc>().state.roomId,
      token: di<ActionsBloc>().state.token,
      displayName: di<ActionsBloc>().state.displayName,
      micEnabled: di<ActionsBloc>().state.micEnabled,
      camEnabled: di<ActionsBloc>().state.camEnabled,
      maxResolution: di<ActionsBloc>().state.maxResolution,
      multiStream: di<ActionsBloc>().state.multiStream,
      defaultCameraIndex: di<ActionsBloc>().state.defaultCameraIndex,
      notification: const NotificationInfo(
        title: "Video SDK",
        message: "Video SDK is sharing screen in the meeting",
        icon: "notification_share", // drawable icon name
      ),
    );

    // Register meeting events
    registerMeetingEvents(room);

    // Join meeting
    room.join();
  }

  @override
  Widget build(BuildContext context) {
    //Get statusbar height

    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: _joined
          ? SafeArea(
              child: Scaffold(
                backgroundColor: PipeColor.kPipeGreen,
                body: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      child: BlocBuilder<ActionsBloc, ActionsState>(
                        builder: (context, state) {
                          return ConferenceParticipantGrid(
                            meeting: meeting,
                          );
                        },
                      ),
                    ),
                  ],
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FloatingActionButton(
                      heroTag: 'cameraswitch_sharp',
                      backgroundColor: PipeColor.kPipeGreen,
                      key: const Key('cameraswitch_sharp'),
                      onPressed: () {
                        final state = context.read<ActionsBloc>().state;
                        if (state.defaultCameraIndex.isEven) {
                          di<ActionsBloc>()
                              .add(const HandleCameraIndexEvent(1));
                          meeting.changeCam(
                            state.defaultCameraIndex.toString(),
                          );
                        } else {
                          di<ActionsBloc>()
                              .add(const HandleCameraIndexEvent(0));
                          meeting.changeCam(
                            state.defaultCameraIndex.toString(),
                          );
                        }
                      },
                      child: const Icon(
                        Icons.cameraswitch_sharp,
                      ),
                    ),
                    FloatingActionButton(
                      heroTag: 'videocam_off',
                      backgroundColor: PipeColor.kPipeGreen,
                      key: const Key('videocam_off'),
                      onPressed: () {
                        final state = context.read<ActionsBloc>().state;
                        if (!state.camEnabled) {
                          showSnackBarMessage(
                            context: context,
                            message: 'Camara abierta',
                          );
                          di<ActionsBloc>().add(HandleCamEnabledEvent());
                          meeting.enableCam();
                        } else {
                          showSnackBarMessage(
                            context: context,
                            message: 'Camara cerrada',
                          );
                          di<ActionsBloc>().add(HandleCamDisabledEvent());
                          meeting.disableCam();
                        }
                      },
                      child: Icon(
                        context.read<ActionsBloc>().state.camEnabled
                            ? Icons.videocam
                            : Icons.videocam_off,
                      ),
                    ),
                    FloatingActionButton(
                      heroTag: 'mic_off',
                      backgroundColor: PipeColor.kPipeGreen,
                      key: const Key('mic_off'),
                      onPressed: () {
                        final state = context.read<ActionsBloc>().state;
                        if (state.micEnabled) {
                          showSnackBarMessage(
                            context: context,
                            message: 'Micrófono cerrado',
                          );
                          meeting.muteMic();
                          di<ActionsBloc>().add(HandleMicDisabledEvent());
                        } else {
                          showSnackBarMessage(
                            context: context,
                            message: 'Micrófono abierto',
                          );
                          meeting.unmuteMic();
                          di<ActionsBloc>().add(HandleMicEnabledEvent());
                        }
                      },
                      child: Icon(context.read<ActionsBloc>().state.micEnabled
                          ? Icons.mic
                          : Icons.mic_off),
                    ),
                  ],
                ),
              ),
            )
          : const LoadingPage(),
    );
  }

  void registerMeetingEvents(Room meeting) {
    // Called when joined in meeting
    meeting.on(
      Events.roomJoined,
      () {
        setState(() {
          this.meeting = meeting;
          _joined = true;
        });

        subscribeToChatMessages(meeting);
      },
    );

    // Called when meeting is ended
    meeting.on(Events.roomLeft, (String? errorMsg) {
      if (errorMsg != null) {
        showSnackBarMessage(
            message: "Meeting left due to $errorMsg !!", context: context);
      }
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(builder: (context) => const JoinScreen()),
      //     (route) => false);
    });

    // Called when recording is started
    meeting.on(Events.recordingStateChanged, (String status) {
      showSnackBarMessage(
          message:
              "Meeting recording ${status == "RECORDING_STARTING" ? "is starting" : status == "RECORDING_STARTED" ? "started" : status == "RECORDING_STOPPING" ? "is stopping" : "stopped"}",
          context: context);

      setState(() {
        recordingState = status;
      });
    });

    // Called when stream is enabled
    meeting.localParticipant.on(Events.streamEnabled, (Stream stream) {
      if (stream.kind == 'video') {
        setState(() {
          videoStream = stream;
        });
      } else if (stream.kind == 'audio') {
        setState(() {
          audioStream = stream;
        });
      } else if (stream.kind == 'share') {
        setState(() {
          shareStream = stream;
        });
      }
    });

    // Called when stream is disabled
    meeting.localParticipant.on(Events.streamDisabled, (Stream stream) {
      if (stream.kind == 'video' && videoStream?.id == stream.id) {
        setState(() {
          videoStream = null;
        });
      } else if (stream.kind == 'audio' && audioStream?.id == stream.id) {
        setState(() {
          audioStream = null;
        });
      } else if (stream.kind == 'share' && shareStream?.id == stream.id) {
        setState(() {
          shareStream = null;
        });
      }
    });

    // Called when presenter is changed
    meeting.on(Events.presenterChanged, (activePresenterId) {
      Participant? activePresenterParticipant =
          meeting.participants[activePresenterId];

      // Get Share Stream
      Stream? stream = activePresenterParticipant?.streams.values
          .singleWhere((e) => e.kind == "share");

      setState(() => remoteParticipantShareStream = stream);
    });

    meeting.on(
        Events.error,
        (error) => {
              showSnackBarMessage(
                  message: "${error['name']} :: ${error['message']}",
                  context: context)
            });
  }

  void subscribeToChatMessages(Room meeting) {
    meeting.pubSub.subscribe("CHAT", (message) {
      if (message.senderId != meeting.localParticipant.id) {
        if (mounted) {
          if (showChatSnackbar) {
            showSnackBarMessage(
                message: "${message.senderName}: ${message.message}",
                context: context);
          }
        }
      }
    });
  }

  Future<bool> _onWillPopScope() async {
    meeting.leave();
    return true;
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    super.dispose();
  }
}
