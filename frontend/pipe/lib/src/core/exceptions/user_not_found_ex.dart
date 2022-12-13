class UserNotFound implements Exception {
  final int? statusCode;
  final String? statusMessage;
  final DateTime? date;

  UserNotFound({this.statusCode, this.statusMessage, this.date});
}
