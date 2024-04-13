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

class LocalNotifications {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final onClickNotification = BehaviorSubject<String>();
  // static final StreamController<String?> selectNotificationStream = StreamController<String?>.broadcast();

  // Handle tap notification
  static void tapNotification(NotificationResponse notificationResponse) {
    onClickNotification.add(notificationResponse.payload!);
   if (notificationResponse.payload != null) {
      //StartAppState currentState = navigationService.navigatorKey.currentState!.context.findAncestorStateOfType<StartAppState>()!;
      //currentState.handleTapNotification();
      // Event event = Event.deserialize(notificationResponse.payload!);
      navigationService.navigatorKey.currentState?.push(
        MaterialPageRoute(builder: (_) => StartApp())
      );
    }
  }

  // Handle notification without tap


  // initialize the local notification
  static Future<void> init() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_noti');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) => null,
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: tapNotification,/* (NotificationResponse notifcationResponse){
          switch(notifcationResponse.notificationResponseType){
            case NotificationResponseType.selectedNotification:
              selectNotificationStream.add(notifcationResponse.payload);
              break;
            case NotificationResponseType.selectedNotificationAction:
          }
        },*/
        onDidReceiveBackgroundNotificationResponse: tapNotification);
  }

  /*Future handleNotificationTap(NotificationResponse notificationResponse) async{
    Navigator.push(context, MaterialPageRoute(builder: (context) => EventDetailsPage(event: _event)));
  }*/

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
        'Time to take your medicine.',
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


}
