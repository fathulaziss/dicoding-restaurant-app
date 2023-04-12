import 'package:dicoding_restaurant_app/data/preferences/preferences_helper.dart';
import 'package:flutter/foundation.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesProvider({required this.preferencesHelper}) {
    _getNotificationStatus();
  }

  PreferencesHelper preferencesHelper;

  bool _isNotificationActive = false;
  bool get isNotificationActive => _isNotificationActive;

  Future<void> _getNotificationStatus() async {
    _isNotificationActive = await preferencesHelper.isNotificationActive;
    notifyListeners();
  }

  void enableNotification({required bool value}) {
    preferencesHelper.enableNotification(value: value);
    _getNotificationStatus();
  }
}
