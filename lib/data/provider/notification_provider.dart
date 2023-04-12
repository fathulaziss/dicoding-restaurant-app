import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:dicoding_restaurant_app/utils/background_service.dart';
import 'package:dicoding_restaurant_app/utils/date_time_helper.dart';
import 'package:flutter/foundation.dart';

class NotificationProvider extends ChangeNotifier {
  bool _isNotificationActive = false;

  bool get isNotificationActive => _isNotificationActive;

  Future<bool> notificationContent({required bool value}) async {
    _isNotificationActive = value;
    if (_isNotificationActive) {
      if (kDebugMode) {
        print('Notification Activated');
      }
      notifyListeners();
      final result = await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
      return result;
    } else {
      if (kDebugMode) {
        print('Notification Canceled');
      }
      notifyListeners();
      final result = await AndroidAlarmManager.cancel(1);
      return result;
    }
  }
}
