import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../app/app_prefs.dart';
import '../../app/imports.dart';
import '../resources/app_router.dart';

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
          try {
            final data = jsonDecode(response.payload!) as Map<String, dynamic>;
            _handleNotificationClick(data);
          } catch (e) {
            log("Error parsing notification payload: $e");
          }
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
        _handleNotificationClick(message.data);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log("On message opened app: ${message.data}");
      _handleNotificationClick(message.data);
    });
  }

  static void _handleNotificationClick(Map<String, dynamic> data) {
    log("Handling notification click with data: $data");
    
    // The data might contain a nested metadata map or be flat
    final Map<String, dynamic> metadata = data['metadata'] is Map 
        ? Map<String, dynamic>.from(data['metadata'] as Map)
        : data;

    final String? type = metadata['type']?.toString();
    final String? targetTab = metadata['target_tab']?.toString();

    if (type == 'supplier_material_purchase_order_chat_message' || targetTab == 'chat') {
      final dynamic orderId = metadata['purchase_order_id'];
      if (orderId != null) {
        final int id = orderId is int ? orderId : int.tryParse(orderId.toString()) ?? 0;
        if (id != 0) {
          final String name = data['title']?.toString() ?? 'Supplier';
          AppRouters.router.push(
            AppRouters.chatView,
            extra: {
              'chatId': id,
              'supplierName': name,
            },
          );
        }
      }
    }
  }

  @pragma('vm:entry-point')
  static Future<void> messageHandler(RemoteMessage message) async {
    log('background message ${message.notification!.toString()}');
    // log('background message ${message.data.toString()}');
  }
}
