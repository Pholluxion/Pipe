import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<String> createMeeting(String token) async {
  final String? videoSdkApiEndPoint = dotenv.env['VIDEOSDK_API_ENDPOINT'];

  final Uri getMeetingIdUrl = Uri.parse('$videoSdkApiEndPoint/rooms');
  final http.Response meetingIdResponse = await http.post(
    getMeetingIdUrl,
    headers: {"Authorization": token},
  );

  if (meetingIdResponse.statusCode != 200) {
    throw Exception(json.decode(meetingIdResponse.body)["error"]);
  }
  var meetingID = json.decode(meetingIdResponse.body)['roomId'];
  return meetingID;
}

Future<bool> validateMeeting(String token, String meetingId) async {
  final String? videoSdkApiEndPoint = dotenv.env['VIDEOSDK_API_ENDPOINT'];

  final Uri validateMeetingUrl =
      Uri.parse('$videoSdkApiEndPoint/rooms/validate/$meetingId');
  final http.Response validateMeetingResponse = await http.get(
    validateMeetingUrl,
    headers: {"Authorization": token},
  );

  if (validateMeetingResponse.statusCode != 200) {
    throw Exception(json.decode(validateMeetingResponse.body)["error"]);
  }

  return validateMeetingResponse.statusCode == 200;
}

Future<dynamic> fetchSession(String token, String meetingId) async {
  final String? videoSdkApiEndPoint = dotenv.env['VIDEOSDK_API_ENDPOINT'];

  final Uri getMeetingIdUrl =
      Uri.parse('$videoSdkApiEndPoint/sessions?roomId=$meetingId');
  final http.Response meetingIdResponse =
      await http.get(getMeetingIdUrl, headers: {
    "Authorization": token,
  });
  List<dynamic> sessions = jsonDecode(meetingIdResponse.body)['data'];
  return sessions.first;
}

Future<dynamic> getRooms(String token) async {
  final String? videoSdkApiEndPoint = dotenv.env['VIDEOSDK_API_ENDPOINT'];

  final Uri getMeetingIdUrl =
      Uri.parse('$videoSdkApiEndPoint/rooms?page=1&perPage=20');
  final http.Response meetingIdResponse =
      await http.get(getMeetingIdUrl, headers: {
    "Authorization": token,
  });
  List<dynamic> sessions = jsonDecode(meetingIdResponse.body)['data'];
  return sessions;
}
