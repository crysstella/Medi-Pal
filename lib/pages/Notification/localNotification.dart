import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../Schedule/event.dart';

class LocalNotifications {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final onClickNotification = BehaviorSubject<String>();

  // On tap notification
  static void tapNotification(NotificationResponse notificationResponse) {
    onClickNotification.add(notificationResponse.payload!);
  }

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
        onDidReceiveNotificationResponse: tapNotification,
        onDidReceiveBackgroundNotificationResponse: tapNotification);
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

  // Show a simple notification
  /*static Future showSimpleNoti({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'id',
      'name',
      channelDescription: 'This is Medipal',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: payload);
  }

  // Show schedule notification
  static Future showScheduleNoti({
    required String title,
    required String body,
    required String payload,
    //required DateTime scheduleTime
  }) async {
    tz.initializeTimeZones();
    var localTime = tz.local;

    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channel 2',
      'channelName',
      channelDescription: 'This is Medipal noti',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.periodicallyShow(
        1, title, body, RepeatInterval.everyMinute, notificationDetails,
        payload: payload);
  }*/
}
