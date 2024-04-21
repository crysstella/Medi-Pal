import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unicons/unicons.dart';
import '../Schedule/event.dart';
import 'localNotification.dart';
import 'notification_details.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => NotificationsState();
}

class NotificationsState extends State<Notifications> {
  static List<Event> events = [];

  @override
  void initState() {
    super.initState();
    /*LocalNotifications.notificationStreamController.stream
        .listen((String event) {
      handleNotification(event);
    });*/
    //listenToNotification();
    //notificationReceived();
  }

  // Handle notification and adding event to page
  void handleNotification(String event) {
    setState(() {
      Event _event = Event.deserialize(event);
      events.add(_event);
      print('length = ${events.length}');
    });
  }

  /*// Listen to any notification
  notificationReceived(){
    LocalNotifications.onNotificationStream.stream.listen((String? event) {
      if (event != null){
        handleNotification(event);
      }
    });
  }*/

  // Listen to any notification clicked or not
  /*listenToNotification() {
    LocalNotifications.onClickNotification.stream.listen((String event) {
      handleNotification(event);
    });
  }*/

  /* @override
  void dispose(){
    LocalNotifications.onNotificationStream.close();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: events.length,
        itemBuilder: (context, index) {
          print('EVENT LENGTH = ${events.length}');
          Event event = events[index];
          return Dismissible(
              key: Key(event.hashCode
                  .toString()), // Use a unique key for Dismissible
              background: Container(color: Colors.red),
              onDismissed: (direction) {
                // Remove the item from the list
                setState(() {
                  events.removeAt(index);
                });

                // Show a snackbar This snackbar could also contain "Undo" actions.
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Reminder dismissed')));
              },
              child: Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text('Medicine Reminder at ${event.getTime(context)}'),
                  subtitle: Text("It's time to take ${event.medicine}."),
                  trailing: const Icon(UniconsLine.angle_right),
                  onTap: () {
                    // Handle the tap
                  },
                ),
              ));
        },
        separatorBuilder: (context, index) => const SizedBox(),
      ),
      /*body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          Event event = events[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text('Medicine Reminder at ${event.getTime(context)}'),
              subtitle: Text("It's time to take ${event.medicine}."),
              trailing: const Icon(UniconsLine.angle_right),
              onTap: () {
                // Handle the tap
              },
            ),
          );
        },
      ),*/
    );
  }
}
