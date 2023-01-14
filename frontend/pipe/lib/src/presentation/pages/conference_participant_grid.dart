import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:videosdk/videosdk.dart';

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
        ...onScreenParticipants.entries
            .map(
              (e) => Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ParticipantGridTile(
                    key: Key(e.value.id),
                    participant: e.value,
                    activeSpeakerId: activeSpeakerId,
                    quality: quality,
                  ),
                ),
              ),
            )
            .toList(),
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
