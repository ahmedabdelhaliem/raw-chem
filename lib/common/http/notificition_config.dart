import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../app/app_prefs.dart';
import '../../app/imports.dart';

class MessagingConfig {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static Future<void> initFirebaseMessaging() async {
    await createNotificationChannel();

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    try {
      await messaging.subscribeToTopic('notifications');
    } catch (e) {
      log('Error subscribing to topic: $e');
    }
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        log("Notification tapped: ${response.payload}");
        if (response.payload != null) {
          // ignore: unused_local_variable
          final data = jsonDecode(response.payload!) as Map<String, dynamic>;
        }
      },
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('User granted provisional permission');
    }
    // Removed redundant subscribeToTopic call
    FirebaseMessaging.instance.onTokenRefresh.listen((newFCM) async {});

    FirebaseMessaging.instance.getToken().then((token) async {
      log('fcm $token');
      final AppPreferences appPreferences = instance<AppPreferences>();
      await appPreferences.saveFcmToken(token!);
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage event) async {
      log("message received: ${event.data}");
      try {
        RemoteNotification? notification = event.notification;
        String? title = notification?.title ?? event.data['title'];
        String? body = notification?.body ?? event.data['body'];

        if (title != null || body != null) {
          await flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            title,
            body,
            const NotificationDetails(
              android: AndroidNotificationDetails(
                'high_importance_channel',
                'High Importance Notifications',
                channelDescription:
                    'This channel is used for important notifications.',
                icon: '@mipmap/ic_launcher',
                importance: Importance.max,
                priority: Priority.high,
              ),
              iOS: DarwinNotificationDetails(
                presentAlert: true,
                presentBadge: true,
                presentSound: true,
              ),
            ),
            payload: jsonEncode(event.data),
          );
        }
      } catch (err) {
        log("Error handling foreground message: $err");
      }
    });

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        log("Initial message: ${message.data}");
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log("On message opened app: ${message.data}");
    });
  }

  @pragma('vm:entry-point')
  static Future<void> messageHandler(RemoteMessage message) async {
    log('background message ${message.notification!.toString()}');
    // log('background message ${message.data.toString()}');
  }
}
