import 'package:flutter_bloc/flutter_bloc.dart';

class MicrofoneCubit extends Cubit<bool> {
  MicrofoneCubit() : super(false);

  void enableMicrofone() {
    emit(true);
  }

  void disableMicrofone() {
    emit(false);
  }
}
