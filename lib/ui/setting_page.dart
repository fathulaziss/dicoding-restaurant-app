import 'dart:io';

import 'package:dicoding_restaurant_app/data/provider/notification_provider.dart';
import 'package:dicoding_restaurant_app/data/provider/preferences_provider.dart';
import 'package:dicoding_restaurant_app/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  static const settingTitle = 'Setting';

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, preferencesProvider, child) {
        return Scaffold(
          appBar: AppBar(title: const Text('Setting')),
          body: Column(
            children: [
              ListTile(
                title: const Text('Restaurant Notification'),
                trailing: Consumer<NotificationProvider>(
                  builder: (context, notificationProvider, child) {
                    return Switch(
                      value: preferencesProvider.isNotificationActive,
                      onChanged: (value) async {
                        if (Platform.isIOS) {
                          customDialog(context);
                        } else {
                          await notificationProvider.notificationContent(
                            value: value,
                          );
                          preferencesProvider.enableNotification(value: value);
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
