abstract class SettingsService {
  Future<void> saveUser(String user);
  Future<void> deleteUser();
  bool showOnboarding();
}
