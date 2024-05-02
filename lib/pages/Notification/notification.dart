import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unicons/unicons.dart';
import '../Schedule/event.dart';
import 'localNotification.dart';
import 'notification_details.dart';

class MyNotification extends Notification {
  final String message;

  MyNotification(this.message);
}

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => NotificationsState();
}

class NotificationsState extends State<Notifications> {
  static List<Event> events = [];
  /*static ValueNotifier<List<Event>> notifiedEvents =
      ValueNotifier<List<Event>>([]);*/

  @override
  void initState() {
    super.initState();
    LocalNotifications.notificationStream.listen((String event) {
      handleNotification(event);
    });
    //listenToNotification();
    //notificationReceived();
  }

  // Handle notification and adding event to page
  void handleNotification(String event) {
    setState(() {
      Event eventTemp = Event.deserialize(event);
      events.add(eventTemp);
      print('length = ${events.length}');
    });
  }

  /*@override
  void dispose() {
    notifiedEvents.dispose();
    LocalNotifications.dispose();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              return ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: events.length,
                itemBuilder: (context, index) {
                  print('EVENT LENGTH = ${events.length}');
                  print('EVENT = ${events}');
                  Event event = events[index];
                  return Dismissible(
                      key: Key(event.hashCode
                          .toString()), // Use a unique key for Dismissible
                      background: Container(color: Colors.red),
                      /*onDismissed: (direction) {
                            // Remove the item from the list
                            setState(() {
                              notifiedEvents.value.removeAt(index);
                            });

                            // Show a snackbar This snackbar could also contain "Undo" actions.
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Reminder dismissed')));
                          },*/
                      child: Card(
                        margin: EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(
                              'Medicine Reminder at ${events[index].getTime(context)}'),
                          subtitle: Text(
                              "It's time to take ${events[index].medicine}."),
                          trailing: const Icon(UniconsLine.angle_right),
                          onTap: () {
                            // Handle the tap
                          },
                        ),
                      ));
                },
                separatorBuilder: (context, index) => const SizedBox(),
              );
            }));

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
  }
}
