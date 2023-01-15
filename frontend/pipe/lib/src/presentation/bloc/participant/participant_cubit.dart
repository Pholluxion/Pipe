import 'package:flutter_bloc/flutter_bloc.dart';

class ParticipantCubit extends Cubit<String> {
  ParticipantCubit() : super('');

  void changeParticipant(String participant) {
    emit(participant);
  }
}
