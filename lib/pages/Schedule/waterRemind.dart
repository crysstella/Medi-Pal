import 'package:flutter/material.dart';
import 'package:medipal/pages/Notification/localNotification.dart';
import 'package:notification_repository/notification_repository.dart';

class SetWaterGoalDialog extends StatefulWidget {
  final int defaultWaterGoalIntake;
  final double initialFrequency;
  final DateTime date;
  final Function(double, List<Event>) onFrequencyChanged;

  SetWaterGoalDialog({
    required this.date,
    required this.defaultWaterGoalIntake,
    required this.initialFrequency,
    required this.onFrequencyChanged,
  });

  @override
  _SetWaterGoalDialogState createState() => _SetWaterGoalDialogState();
}

class _SetWaterGoalDialogState extends State<SetWaterGoalDialog> {
  late double frequency;
  late DateTime date;

  @override
  void initState() {
    super.initState();
    frequency = widget.initialFrequency;
    date = widget.date;
  }

  List<Event> calculateReminderTimes(WaterReminder waterEvent) {
    List<Event> reminders = [];
    TimeOfDay sleepTime = waterEvent.sleepTime;
    TimeOfDay wakeUpTime = waterEvent.wakeUpTime;
    int totalAwakeMinutes = (sleepTime.hour - wakeUpTime.hour) * 60 +
        (sleepTime.minute - wakeUpTime.minute);
    int intervalMinutes = totalAwakeMinutes ~/ waterEvent.frequency;

    for (int i = 0; i < frequency; i++) {
      int nextMinutes =
          wakeUpTime.hour * 60 + wakeUpTime.minute + i * intervalMinutes;
      int nextHour = nextMinutes ~/ 60;
      int nextMinute = nextMinutes % 60;

      if (nextHour >= 24) {
        nextHour %= 24; // Move to the next day if needed
      }

      // Create a DateTime for the reminder.
      DateTime reminderTime = DateTime(
          date.year, date.month, date.day, nextHour, nextMinute, nextMinute);

      // Add the new WaterReminder to the list
      Event waterReminder = WaterReminder(
        amount: waterEvent.amount,
        date: reminderTime,
        time: TimeOfDay(hour: reminderTime.hour, minute: reminderTime.minute),
        frequency: waterEvent.frequency,
        wakeUpTime: waterEvent.wakeUpTime,
        sleepTime: waterEvent.sleepTime,
      );

      LocalNotifications.scheduleNotification(event: waterReminder);
      reminders.add(waterReminder);
    }
    return reminders;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Set Water Goal"),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextField(
              enabled: false,
              controller: TextEditingController(
                  text: '${widget.defaultWaterGoalIntake} ounces'),
              decoration: const InputDecoration(
                labelText: 'Water Goal Calculated',
                helperText: 'Calculated goal based on your weight.',
              ),
            ),
            const SizedBox(height: 10),
            Slider(
              value: frequency,
              min: 1,
              max: 15,
              divisions: 14,
              label: '$frequency times a day.',
              activeColor: Theme.of(context).primaryColor,
              inactiveColor: Theme.of(context).colorScheme.inversePrimary,
              onChanged: (newValue) {
                setState(() {
                  frequency = newValue;
                });
              },
            ),
            Text(
                'You will be reminded ${frequency.round()} times a day to drink water.')
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
            child: const Text('Set'),
            onPressed: () {
              int amountPerReminder = (widget.defaultWaterGoalIntake / frequency.round()).toInt();
              TimeOfDay nowTime = TimeOfDay.fromDateTime(date);
              WaterReminder waterReminder = WaterReminder(
                  amount: amountPerReminder,
                  date: date,
                  time: nowTime,
                  frequency: frequency.round(),
                  wakeUpTime: TimeOfDay(hour: 6, minute: 0),
                  sleepTime: TimeOfDay(hour: 22, minute: 0));

              // Calculate reminders based on user's settings
              List<Event> reminders = calculateReminderTimes(waterReminder);
              // Call the callback with frequency and reminders
              widget.onFrequencyChanged(frequency, reminders);

              // Close the dialog
              Navigator.of(context).pop();
            })
      ],
    );
  }
}