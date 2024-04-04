import 'package:flutter/material.dart';
import 'localNotification.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => NotificationsState();
}

class NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Notifications'),
              TextButton(
                  onPressed: () {
                    LocalNotifications.showSimpleNoti(
                        title: 'MediPal Notification',
                        body: 'Simple Notification',
                        payload: 'MediPal data');
                  },
                  child: Text('Local Notification')),
              TextButton(
                  onPressed: () {
                    LocalNotifications.showScheduleNoti(
                        title: 'Medi-Pal',
                        body: 'Schedule Notification',
                        payload: 'MediPal data');
                  },
                  child: Text('Schedule Notification'))
            ]),
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => NotificationsState();
}

class NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text('Notifications')]),
      ),
    );
  }
}

*/
