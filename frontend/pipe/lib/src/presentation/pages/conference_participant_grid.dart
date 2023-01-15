import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pipe/src/di.dart';
import 'package:videosdk/videosdk.dart';

import '../bloc/participant/participant_cubit.dart';
import 'participant_grid_tile.dart';

class ConferenceParticipantGrid extends StatefulWidget {
  final Room meeting;
  const ConferenceParticipantGrid({Key? key, required this.meeting})
      : super(key: key);

  @override
  State<ConferenceParticipantGrid> createState() =>
      _ConferenceParticipantGridState();
}

class _ConferenceParticipantGridState extends State<ConferenceParticipantGrid> {
  late Participant localParticipant;
  String? activeSpeakerId;
  String? presenterId;
  int numberofColumns = 1;
  int numberOfMaxOnScreenParticipants = 6;
  String quality = "high";

  Map<String, Participant> participants = {};
  Map<String, Participant> onScreenParticipants = {};

  @override
  void initState() {
    localParticipant = widget.meeting.localParticipant;
    participants.putIfAbsent(localParticipant.id, () => localParticipant);
    participants.addAll(widget.meeting.participants);
    presenterId = widget.meeting.activePresenterId;
    updateOnScreenParticipants();
    // Setting meeting event listeners
    setMeetingListeners(widget.meeting);

    di<ParticipantCubit>().changeParticipant(localParticipant.id);

    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 3,
          child: BlocBuilder(
            bloc: di<ParticipantCubit>(),
            builder: (context, String state) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: onScreenParticipants.containsKey(state)
                    ? ParticipantGridTile(
                        key: Key(state),
                        participant: onScreenParticipants[state]!,
                        activeSpeakerId: activeSpeakerId,
                        quality: quality,
                      )
                    : onScreenParticipants.length == 1
                        ? ParticipantGridTile(
                            key: Key(localParticipant.id),
                            participant: localParticipant,
                            activeSpeakerId: activeSpeakerId,
                            quality: quality,
                          )
                        : const Center(
                            child: Icon(
                              Icons.sentiment_very_satisfied_outlined,
                              size: 150.0,
                            ),
                          ),
              );
            },
          ),
        ),
        BlocBuilder(
          bloc: di<ParticipantCubit>(),
          builder: (context, state) {
            return Visibility(
              visible: onScreenParticipants.length > 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ...onScreenParticipants.entries.map(
                      (e) {
                        return e.key == state
                            ? const SizedBox()
                            : SizedBox(
                                width: 200,
                                height: 150,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: ParticipantGridTile(
                                    key: Key(e.value.id),
                                    participant: e.value,
                                    activeSpeakerId: activeSpeakerId,
                                    quality: quality,
                                  ),
                                ),
                              );
                      },
                    ).toList(),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void setMeetingListeners(Room meeting) {
    // Called when participant joined meeting
    meeting.on(
      Events.participantJoined,
      (Participant participant) {
        final newParticipants = participants;
        newParticipants[participant.id] = participant;
        setState(() {
          participants = newParticipants;
          updateOnScreenParticipants();
        });
      },
    );

    // Called when participant left meeting
    meeting.on(
      Events.participantLeft,
      (participantId) {
        final newParticipants = participants;

        newParticipants.remove(participantId);
        setState(() {
          participants = newParticipants;
          updateOnScreenParticipants();
        });
      },
    );

    meeting.on(
      Events.speakerChanged,
      (activeSpeakerId) {
        setState(() {
          activeSpeakerId = activeSpeakerId;
          updateOnScreenParticipants();
        });
      },
    );

    meeting.on(Events.presenterChanged, (presenterId) {
      setState(() {
        presenterId = presenterId;
        numberOfMaxOnScreenParticipants = presenterId != null ? 2 : 6;
        updateOnScreenParticipants();
      });
    });

    meeting.localParticipant.on(Events.streamEnabled, (Stream stream) {
      if (stream.kind == "share") {
        setState(() {
          numberOfMaxOnScreenParticipants = 2;
          updateOnScreenParticipants();
        });
      }
    });
    meeting.localParticipant.on(Events.streamDisabled, (Stream stream) {
      if (stream.kind == "share") {
        setState(() {
          numberOfMaxOnScreenParticipants = 6;
          updateOnScreenParticipants();
        });
      }
    });
  }

  updateOnScreenParticipants() {
    Map<String, Participant> newScreenParticipants = <String, Participant>{};
    participants.values
        .toList()
        .sublist(
            0,
            participants.length > numberOfMaxOnScreenParticipants
                ? numberOfMaxOnScreenParticipants
                : participants.length)
        .forEach((participant) {
      newScreenParticipants.putIfAbsent(participant.id, () => participant);
    });
    if (!newScreenParticipants.containsKey(activeSpeakerId) &&
        activeSpeakerId != null) {
      newScreenParticipants.remove(newScreenParticipants.keys.last);
      newScreenParticipants.putIfAbsent(
          activeSpeakerId!,
          () => participants.values
              .firstWhere((element) => element.id == activeSpeakerId));
    }
    if (!listEquals(newScreenParticipants.keys.toList(),
        onScreenParticipants.keys.toList())) {
      setState(() {
        onScreenParticipants = newScreenParticipants;
        quality = newScreenParticipants.length > 4
            ? "low"
            : newScreenParticipants.length > 2
                ? "medium"
                : "high";
      });
    }
    if (numberofColumns !=
        (newScreenParticipants.length > 2 ||
                numberOfMaxOnScreenParticipants == 2
            ? 2
            : 1)) {
      setState(() {
        numberofColumns = newScreenParticipants.length > 2 ||
                numberOfMaxOnScreenParticipants == 2
            ? 2
            : 1;
      });
    }
  }
}
