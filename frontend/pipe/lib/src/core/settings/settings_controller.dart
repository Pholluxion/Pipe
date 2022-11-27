import 'package:shared_preferences/shared_preferences.dart';

import 'settings_service.dart';

class SettingsController implements SettingsService {
  static final SettingsController _singleton = SettingsController._internal();

  factory SettingsController() => _singleton;

  SettingsController._internal();

  late SharedPreferences prefs;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<void> deleteUser() async {
    try {
      final user = prefs.getString('user') ?? '';
      if (user.isNotEmpty) {
        prefs.setString('user', '');
      }
    } catch (_) {
      throw Exception('No hay un usuario registrado');
    }
  }

  @override
  Future<void> saveUser(String user) async {
    try {
      await prefs.setString('user', user);
      prefs.setBool('onboarding', false);
    } catch (_) {
      throw Exception('No se pudo registrar el usuario');
    }
  }

  @override
  bool showOnboarding() {
    try {
      final onboarding = prefs.getBool('onboarding');

      if (onboarding != null) {
        return onboarding;
      } else {
        return true;
      }
    } catch (_) {
      throw Exception('Error en onboarding');
    }
  }
}

final SettingsController settingsController = SettingsController();
