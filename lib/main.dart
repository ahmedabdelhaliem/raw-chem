import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/app.dart';
import 'app/imports.dart';
import 'common/http/notificition_config.dart';
import 'common/resources/language_manager.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock orientation to portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize Firebase once
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }

  // Firebase Messaging
  await MessagingConfig.initFirebaseMessaging();
  FirebaseMessaging.onBackgroundMessage(MessagingConfig.messageHandler);

  // Initialize EasyLocalization and App Module
  await Future.wait([EasyLocalization.ensureInitialized(), initAppModule()]);

  runApp(
    EasyLocalization(
      supportedLocales: const [ENGLISH_LOCALE, ARABIC_LOCALE],
      path: ASSET_PASS_LANGUAGE,
      child: MyApp(),
    ),
  );
}
