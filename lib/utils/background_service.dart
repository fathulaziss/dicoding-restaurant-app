import 'dart:isolate';
import 'dart:ui';

import 'package:dicoding_restaurant_app/data/api/api_service.dart';
import 'package:dicoding_restaurant_app/main.dart';
import 'package:dicoding_restaurant_app/utils/notification_helper.dart';
import 'package:flutter/foundation.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  factory BackgroundService() => _instance ?? BackgroundService._internal();

  BackgroundService._internal() {
    _instance = this;
  }
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    if (kDebugMode) {
      print('Alarm fired!');
    }
    final notificationHelper = NotificationHelper();
    final result = await ApiService().getRestaurant();
    await notificationHelper.showNotification(
      flutterLocalNotificationsPlugin,
      result,
    );

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
