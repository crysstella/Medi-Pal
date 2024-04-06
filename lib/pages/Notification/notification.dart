import 'package:flutter/material.dart';
import '../Schedule/event.dart';
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
              /*TextButton(
                  onPressed: () {
                    LocalNotifications.showSimpleNoti(
                        title: 'MediPal Notification',
                        body: 'Simple Notification',
                        payload: 'MediPal data');
                  },
                  child: Text('Local Notification')),
              TextButton(
                  onPressed: () {
                    LocalNotifications.scheduleNotification(
                    Event(medicine: 'tylenol', date: DateTime.now(), time: TimeOfDay(hour: 18, minute: 32)));
                  },
                  child: Text('Schedule Notification'))*/
            ]),
      ),
    );
  }
}

/*@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notification Title $index'),
              subtitle: Text('This is a description of the notification.'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Handle the tap
              },
            ),
          );
        },
      ),
    );
  }*/