/*
import 'package:flutter/material.dart';

import '../Schedule/event.dart';

class EventDetailsPage extends StatefulWidget {
  final Event event;

  const EventDetailsPage({Key? key, required this.event}) : super(key: key);

  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Notification Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Medicine: ${widget.event.medicine}',
            ),
            SizedBox(height: 8.0),
            Text(
              'Date: ${widget.event.date.toString()}',
            ),
            SizedBox(height: 8.0),
            Text(
              'Time: ${widget.event.time.format(context)}',
            ),
            SizedBox(height: 16.0),

          ],
        ),
      ),
    );
  }
}
*/
