import 'dart:convert';

import '../../../core/settings/settings_controller.dart';
import '../../../domain/entities/user_response_entity.dart';
import '../../models/user_data_model.dart';

final user = SettingsController().prefs.getString('user');
final UserResponseEntity userResponseEntity =
    UserDataModel.fromJson(json.decode(user.toString()));
