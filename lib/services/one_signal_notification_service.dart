import 'dart:developer';

import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:va_bot_admin/services/pref_service.dart';

final bool requireConsent = true;

class OneSignalNotificationService {
  static const String oneSignalAppId = '59df38e3-a27a-4f4c-bd65-9e19c39fbff7';
  static bool requireConsent = false;

  static Future<void> initOneSignalPlatformState() async {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.Debug.setAlertLevel(OSLogLevel.none);
    OneSignal.consentRequired(requireConsent);
    OneSignal.initialize(oneSignalAppId);
    OneSignal.Notifications.clearAll();
    if (PrefService.getBool(PrefService.isLogin)) {
      await getOneSignalDeviceToken();
    }
  }

  static Future<void> getOneSignalDeviceToken() async {
    String onSignalId = await OneSignal.User.getOnesignalId() ?? '';
    PrefService.setValue(PrefService.oneSignalId, onSignalId);
    log('One === $onSignalId');
    OneSignal.User.pushSubscription.optIn();
    OneSignal.User.pushSubscription.addObserver((state) {
      String subscriptionId = OneSignal.User.pushSubscription.id ?? '';
      PrefService.setValue(PrefService.oneSignalSubscriptionId, subscriptionId);
      log("One sub id : ${OneSignal.User.pushSubscription.id}");
    });
  }

  static Future<void> requestNotificationPermission() async {
    await Permission.notification.request();
    // OneSignal.Notifications.requestPermission(false);
    await getOneSignalDeviceToken();
  }
}
