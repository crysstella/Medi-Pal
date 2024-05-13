import 'package:bloc_notification/bloc_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:unicons/unicons.dart';
import '../../blocs/notification_bloc/notification_bloc.dart';


class Notifications extends StatefulWidget {
  // Notifications({Key? key, required this.notificationBloc}) : super(key: key);

  const Notifications({super.key});

  @override
  State<Notifications> createState() => NotificationsState();
}

class NotificationsState extends State<Notifications> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocNotificationListener<NotificationBloc, NotificationState,
            MyNotifications>(
      notificationListener: (context, notification) {
        if (notification is UpdateNotificationPageIndex) {
          // When page update
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Theme.of(context).primaryColor,
              content: Text("Notification page updated!")));
        }
      },
      child: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
           return ListView.builder(
            itemCount: state.events.length,
            itemBuilder: (context, index) {
              String title;
              String body;

              final event = state.events[index];

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

              print('THIS IS IN BLOCBUILDER NOTIFICATION PAGE');
              print(event);
              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text('${title} at ${event.getTime(context)}'),
                  subtitle: Text(body),
                  trailing: const Icon(UniconsLine.angle_right),
                  onTap: () {
                    // Handle the tap
                  },
                ),
              );
            },
          );
        },
      ),
    ));
  }
  /*body: ValueListenableBuilder<List<Event>>(
        valueListenable: notifiedEvents,
        builder: (context, events, child) {
          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              Event event = events[index];
              return ListTile(
                title: Text('Reminder for ${event.medicine}'),
                subtitle: Text('Scheduled at ${event.time.format(context)} on ${event.date}'),
              );
            },
          );
        },
      ),*/
  /*ListView.separated(
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
      ),*/
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