import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:medipal/blocs/notification_bloc/notification_bloc.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotifications {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  /*//static final onClickNotification = BehaviorSubject<String>();
  static StreamController<int> indexUpdateController =
      StreamController<int>.broadcast();
  static StreamController<String> notificationStreamController =
      StreamController<String>.broadcast();
  final StreamController<ReceivedNotification>
      didReceiveLocalNotificationStream =
      StreamController<ReceivedNotification>.broadcast();
  final StreamController<String?> selectNotificationStream =
      StreamController<String?>.broadcast();*/

  // initialize the local notification
  static void init(BuildContext context) async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_noti');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        // foreground
        onDidReceiveNotificationResponse: (NotificationResponse response) {
      // Extract details and add the event to the bloc
      final details = extractEventDetails(response.payload);
      print('INIT LOCAL NOTIFICATION = ${details}');
      BlocProvider.of<NotificationBloc>(context)
          .add(ReceiveNotificationEvent(details));
    },
     );
    /*final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {
        didReceiveLocalNotificationStream.add(
          ReceivedNotification(
            id: id,
            title: title,
            body: body,
            payload: payload,
          ),
        );
      },
    );*/

    /*final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );*/
    /*await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        selectNotificationStream.add(notificationResponse.payload);
      },
      onDidReceiveBackgroundNotificationResponse: tapNotificationBackGround,
    );*/
    /*onDidReceiveNotificationResponse: tapNotificationForeGround,
        onDidReceiveBackgroundNotificationResponse: tapNotificationBackGround);*/
  }

  static Event extractEventDetails(String? payload) {
    if (payload == null || payload.isEmpty) {
      throw Exception("Payload is null or empty");
    }
    // Deserialize the payload
    return Event.deserialize(payload);
  }

  /* static void dispose() {
    indexUpdateController.close();
  }*/

  // Handle tap foreground notification
  /*static Future<void> tapNotificationForeGround(
      NotificationResponse notificationResponse) async {
    if (notificationResponse.payload != null) {
      String eventPayLoad = notificationResponse.payload!;
      notificationStreamController.add(eventPayLoad);
      print('FOREGROUND');
      indexUpdateController.add(2);

      // Update events in notification page
      Event _event = Event.deserialize(eventPayLoad);
      notifiedEvents.value = List.from(notifiedEvents.value)..add(_event);
      //NotificationsState.events.add(_event);
    }
  }*/

  // Handle tap background notification
  /* void tapNotificationBackGround(NotificationResponse notificationResponse) {
    if (notificationResponse.input?.isNotEmpty ?? false) {
      // ignore: avoid_print
      print(
          'notification action tapped with input: ${notificationResponse.input}');
    }
    */ /*notificationStreamController.add(notificationResponse.payload!);
    if (notificationResponse.payload != null) {
      navigationService.navigatorKey.currentState
          ?.push(MaterialPageRoute(builder: (_) => StartApp()));
    }*/ /*
  }*/

  static notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails('Event Hash', 'Event Reminders',
          channelDescription: 'Channel for event reminders',
          importance: Importance.max,
          priority: Priority.high),
    );
  }

  static Future scheduleNotification({
    required Event event,
  }) async {
    String title;
    String body;

    if (event is MedicineReminder) {
      title = event.getTitle();
      body = event.getBody();
    } else if (event is WaterReminder) {
      title = event.getTitle();
      body = event.getBody();
    } else {
      title = "Reminder";
      body = 'You have a scheduled reminder.';
    }
      await flutterLocalNotificationsPlugin.zonedSchedule(
        event.getHash(),
        title,
        body,
        tz.TZDateTime.from(
            DateTime(event.date.year, event.date.month, event.date.day,
                event.time.hour, event.time.minute/*, event.date.second*/),
            tz.local),
        await notificationDetails(),
        payload: event.serialize(),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );}

  // Close a specific channel notification
  static Future<void> cancel(int id) async {
    print('EVENT ID = ${id}');
    // Show unpresented/scheduled notifications
    final List<PendingNotificationRequest> pendingNotificationRequests =
    await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    for (var _pendingRequest in pendingNotificationRequests) {
      if (_pendingRequest.id == id){
        print(_pendingRequest.id);
        flutterLocalNotificationsPlugin.cancel(_pendingRequest.id);
      }
    }
  }
}