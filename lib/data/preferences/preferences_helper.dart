import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  PreferencesHelper({required this.sharedPreferences});

  final Future<SharedPreferences> sharedPreferences;

  static const notification = 'NOTIFICATION';
  static const notifIndex = 'NOTIFICATION_INDEX';

  Future<bool> get isNotificationActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(notification) ?? false;
  }

  Future<void> enableNotification({required bool value}) async {
    final prefs = await sharedPreferences;
    await prefs.setBool(notification, value);
  }

  Future<int> get notificationIndex async {
    final prefs = await sharedPreferences;
    return prefs.getInt(notifIndex) ?? 0;
  }

  Future<void> setNotificationIndex({required int value}) async {
    final prefs = await sharedPreferences;
    await prefs.setInt(notifIndex, value);
  }
}
