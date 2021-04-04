import 'package:admob_flutter/admob_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'app.dart';
import 'presentation/articleDetails/article_details_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  timeago.setLocaleMessages('zh', timeago.ZhMessages());
  initializeDateFormatting("zh_HK", null);
  if (kDebugMode) {
    // Force disable Crashlytics collection while doing every day development.
    // Temporarily toggle this to true if you want to test crash reporting in your app.
    await FirebaseCrashlytics.instance
        .setCrashlyticsCollectionEnabled(true);
  } else {
    // Handle Crashlytics enabled status when not in Debug,
    // e.g. allow your users to opt-in to crash reporting.
    await FirebaseCrashlytics.instance
        .setCrashlyticsCollectionEnabled(true);
  }

  Admob.initialize(testDeviceIds: ["A140E2ABE2B7251DC7F07890E8988679"]);

  NotificationSettings permissionResponse = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  debugPrint("permissionResponse, $permissionResponse");
  if (permissionResponse.authorizationStatus == AuthorizationStatus.authorized) {
    FirebaseMessaging.instance.subscribeToTopic("news");
    debugPrint("subscribed to topic: news");
  }
  runApp(ApplicationWrapper());
}
