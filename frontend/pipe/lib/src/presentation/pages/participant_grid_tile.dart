import 'package:flutter/material.dart';
import 'package:videosdk/videosdk.dart';

class ParticipantGridTile extends StatefulWidget {
  final Participant participant;
  final bool isLocalParticipant;
  final String? activeSpeakerId;
  final String? quality;
  const ParticipantGridTile(
      {Key? key,
      required this.participant,
      required this.quality,
      this.isLocalParticipant = false,
      required this.activeSpeakerId})
      : super(key: key);

  @override
  State<ParticipantGridTile> createState() => _ParticipantGridTileState();
}

class _ParticipantGridTileState extends State<ParticipantGridTile> {
  Stream? videoStream;
  Stream? audioStream;

  @override
  void initState() {
    _initStreamListeners();
    super.initState();

    widget.participant.streams.forEach((key, Stream stream) {
      setState(() {
        if (stream.kind == 'video') {
          videoStream = stream;
          widget.participant.setQuality(widget.quality);
        } else if (stream.kind == 'audio') {
          audioStream = stream;
        }
      });
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.black,
        border: widget.activeSpeakerId != null &&
                widget.activeSpeakerId == widget.participant.id
            ? Border.all(color: Colors.purple)
            : null,
      ),
      child: Stack(
        children: [
          videoStream != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: RTCVideoView(
                    videoStream?.renderer as RTCVideoRenderer,
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                  ),
                )
              : Center(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                    child: Text(
                      widget.participant.displayName.characters.first
                          .toUpperCase(),
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                ),
          if (audioStream == null)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(
                    Icons.mic_off,
                    size: 15,
                  )),
            ),
          Positioned(
            bottom: 4,
            left: 4,
            child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(widget.participant.isLocal
                    ? "Tú"
                    : widget.participant.displayName)),
          ),
        ],
      ),
    );
  }

  _initStreamListeners() {
    widget.participant.on(Events.streamEnabled, (Stream stream) {
      setState(() {
        if (stream.kind == 'video') {
          videoStream = stream;
          widget.participant.setQuality(widget.quality);
        } else if (stream.kind == 'audio') {
          audioStream = stream;
        }
      });
    });

    widget.participant.on(Events.streamDisabled, (Stream stream) {
      setState(() {
        if (stream.kind == 'video' && videoStream?.id == stream.id) {
          videoStream = null;
        } else if (stream.kind == 'audio' && audioStream?.id == stream.id) {
          audioStream = null;
        }
      });
    });

    widget.participant.on(Events.streamPaused, (Stream stream) {
      setState(() {
        if (stream.kind == 'video' && videoStream?.id == stream.id) {
          videoStream = null;
        } else if (stream.kind == 'audio' && audioStream?.id == stream.id) {
          audioStream = stream;
        }
      });
    });

    widget.participant.on(Events.streamResumed, (Stream stream) {
      setState(() {
        if (stream.kind == 'video' && videoStream?.id == stream.id) {
          videoStream = stream;
          widget.participant.setQuality(widget.quality);
        } else if (stream.kind == 'audio' && audioStream?.id == stream.id) {
          audioStream = stream;
        }
      });
    });
  }
}
