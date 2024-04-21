import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:medipal/components/navigation_service/navigationService.dart';
import 'package:medipal/pages/Start/startApp.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../Schedule/event.dart';
import 'notification.dart';
import 'notification_details.dart';

/*final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
    StreamController<ReceivedNotification>.broadcast();
final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast();

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });
  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

String? selectedNotificationPayload;*/

class LocalNotifications {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  //static final onClickNotification = BehaviorSubject<String>();
  static StreamController<int> indexUpdateController =
      StreamController<int>.broadcast();
  static StreamController<String> notificationStreamController =
      StreamController<String>.broadcast();

  //static final BehaviorSubject<String?> onNotificationStream =
  // BehaviorSubject<String?>();

  // initialize the local notification
  static Future<void> init() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_noti');
    /*final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: _onDidReceiveLocalNotification*/ /*(id, title, body, payload) => null*/ /*);*/
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: tapNotificationForeGround,
        onDidReceiveBackgroundNotificationResponse: tapNotificationBackGround);
  }

  static void dispose() {
    indexUpdateController.close();
  }

  // Handle tap foreground notification
  static Future<void> tapNotificationForeGround(
      NotificationResponse notificationResponse) async {
    if (notificationResponse.payload != null) {
      String eventPayLoad = notificationResponse.payload!;
      notificationStreamController.add(eventPayLoad);
      print('FOREGROUND');
      indexUpdateController.add(2);

      // Update events in notification page
      Event _event = Event.deserialize(eventPayLoad);
      NotificationsState.events.add(_event);

     /* // Check if StartApp is already the current screen
      if (navigationService.navigatorKey.currentState?.context.widget is! Notifications) {
        navigationService.navigatorKey.currentState
            ?.push(MaterialPageRoute(builder: (_) => Notifications()));      }*/

    }
  }

  // Handle tap background notification
  static void tapNotificationBackGround(
      NotificationResponse notificationResponse) async {
    notificationStreamController.add(notificationResponse.payload!);
    if (notificationResponse.payload != null) {
      navigationService.navigatorKey.currentState
          ?.push(MaterialPageRoute(builder: (_) => StartApp()));
    }
  }

  static notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails('eventID', 'Event Reminders',
          channelDescription: 'Channel for event reminders',
          importance: Importance.max,
          priority: Priority.high),
    );
  }

  static Future scheduleNotification({
    required Event event,
  }) async =>
      await flutterLocalNotificationsPlugin.zonedSchedule(
        event.hashCode,
        event.medicine,
        'Time to take ${event.medicine}.',
        tz.TZDateTime.from(
            DateTime(
              event.date.year,
              event.date.month,
              event.date.day,
              event.time.hour,
              event.time.minute,
            ),
            tz.local),
        await notificationDetails(),
        payload: event.serialize(),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );

  // Close a specific channel notification
  static Future cancel(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
