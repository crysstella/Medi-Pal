import 'package:bloc_notification/bloc_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:medipal/pages/Schedule/dose.dart';
import 'package:medipal/pages/Schedule/waterRemind.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:unicons/unicons.dart';
import 'package:timezone/data/latest.dart' as tz;
import '../../blocs/notification_bloc/notification_bloc.dart';
import '../../firebase/services.dart';
import '../Notification/localNotification.dart';

class MedicationSchedule extends StatefulWidget {
  const MedicationSchedule({super.key});

  @override
  State<MedicationSchedule> createState() => _MedicationScheduleState();
}

class _MedicationScheduleState extends State<MedicationSchedule>
    with SingleTickerProviderStateMixin {
  final DataService medService = DataService();
  DateTime today = DateTime.now();
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _format = CalendarFormat.month;
  Icon _buttonDropDown = const Icon(UniconsLine.angle_up);

  bool _isExpanded = false;
  TimeOfDay timeSelected = TimeOfDay.now();
  late ValueNotifier<TimeOfDay> timeNotifier;

  // Dose
  String currentDoseForm = 'Select Form';
  late ValueNotifier<String?> doseError;

  // Store the events created
  static Map<DateTime, List<Event>> events = {};
  //static Map<DateTime, List<Water>> waters = {};

  // Editing Controller
  TextEditingController medicineController = TextEditingController();
  late ValueNotifier<List<Event>> _selectedEvents;
  late ValueNotifier<String?> error;
  late ValueNotifier<String?> errorTimeNotifier;
  final formNameKey = GlobalKey<FormState>();

  // Listen to edit reminder
  bool isEdit = false;
  DateTime? editDate;

  // Medicine list names
  late List<String> medList;

  // Water Reminder
  bool waterMode = false;
  TimeOfDay startTime = TimeOfDay(hour: 8, minute: 0); // Start drinking at 8 AM
  double frequency = 3;

  Future<void> requestNotificationPermission() async {
    var status = await Permission.notification.status;
    if (status.isDenied || status.isPermanentlyDenied) {
      // Open settings if permanently denied
      debugPrint(status.toString());
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Notification Permission"),
          content: Text(
              "This feature needs notification permissions to function properly. Please enable it in the settings."),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text("Settings"),
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => requestNotificationPermission());
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(getEventsForDay(_selectedDay!));
    timeNotifier = ValueNotifier(timeSelected);
    error = ValueNotifier(null);
    errorTimeNotifier = ValueNotifier(null);
    doseError = ValueNotifier(null);
    tz.initializeTimeZones();
    loadMedNames();
  }

  @override
  void dispose() {
    timeNotifier.dispose();
    super.dispose();
  }

  DateTime getNormalizedDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  void daySelected(DateTime day, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, day)) {
      setState(() {
        _selectedDay = day;
        _focusedDay = focusedDay;
      });
    }
    _selectedEvents.value = getEventsForDay(getNormalizedDate(day));
  }

  void formatChanged() => setState(() {
        _format = _format == CalendarFormat.month
            ? CalendarFormat.week
            : CalendarFormat.month;
        _buttonDropDown = _format == CalendarFormat.month
            ? const Icon(UniconsLine.angle_up)
            : const Icon(UniconsLine.angle_down);
      });

  // Handle focus button to go back to today date.
  void toToday() {
    setState(() {
      _selectedDay = DateTime.now();
      _focusedDay = DateTime.now();
    });
    _selectedEvents.value = getEventsForDay(getNormalizedDate(_selectedDay!));
  }

// Convert TimeOfDay to a comparable value (minutes from midnight)
  int timeOfDayToMinutes(TimeOfDay time) {
    return time.hour * 60 + time.minute;
  }

  List<Event> getEventsForDay(DateTime date) {
    List<Event> dayEvents = events[getNormalizedDate(date)] ?? [];
    dayEvents.sort((a, b) =>
        timeOfDayToMinutes(a.time).compareTo(timeOfDayToMinutes(b.time)));

    return dayEvents;
  }

  String? validateName() {
    if (medicineController.text.isEmpty) {
      setState(() {
        error.value = 'Invalid medicine name.';
      });
    } else {
      setState(() {
        error.value = null;
      });
    }
    return error.value;
  }

  void validateTime(DateTime time) {
    debugPrint('SELECTED DAY:${_selectedDay} ');
    debugPrint('TIME PICK ${time}');

    DateTime selected =
        DateTime(_selectedDay!.year, _selectedDay!.month, _selectedDay!.day);
    DateTime thisMoment = DateTime(today.year, today.month, today.day);

    if (selected.isAfter(thisMoment)) {
      setState(() {
        errorTimeNotifier.value = null;
        timeNotifier.value = TimeOfDay.fromDateTime(time);
        timeSelected = timeNotifier.value;
      });
    } else if (selected.isAtSameMomentAs(thisMoment)) {
      if (time.isBefore(DateTime.now().add(const Duration(minutes: 1)))) {
        setState(() {
          errorTimeNotifier.value =
              'Selected time cannot be in the past or too close to now.';
        });
      } else {
        setState(() {
          errorTimeNotifier.value = null;
          timeNotifier.value = TimeOfDay.fromDateTime(time);
          timeSelected = timeNotifier.value;
        });
      }
    }
  }

  void validateDose(String dose) {
    if (currentDoseForm != 'Select Form') {
      setState(() {
        doseError.value = null;
      });
    } else {
      setState(() {
        doseError.value = 'Please select dose.';
      });
    }
  }

  void addEventsForDate(Event newEvent) {
    if (events[getNormalizedDate(newEvent.date)] != null) {
      //debugPrint('Events in $date day is not null');
      events[getNormalizedDate(newEvent.date)]?.add(newEvent);
    } else {
      //debugPrint(events[getNormalizedDate(date)]?.length);
      events[getNormalizedDate(newEvent.date)] = [newEvent];
    }
  }

  void removeEventFromSchedule(Event targetEvent) {
    DateTime dateKey = getNormalizedDate(targetEvent.date);
    if (events.containsKey(dateKey)) {
      debugPrint('LENGTH BEFORE REMOVE = ${events[dateKey]!.length}');
      events[dateKey]!.removeWhere((event) => event.id == targetEvent.id);
      if (events[dateKey]!.isEmpty) {
        events.remove(dateKey);
      }
      _selectedEvents.value = getEventsForDay(targetEvent.date);
    } else {
      debugPrint('The event is not set up yet.');
    }
  }

  TimePickerSpinner showTimePicker(BuildContext context) {
    return TimePickerSpinner(
        alignment: Alignment.center,
        is24HourMode: true,
        normalTextStyle:
            const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        highlightedTextStyle:
            TextStyle(fontSize: 25, color: Theme.of(context).primaryColor),
        spacing: 18,
        itemHeight: 60,
        itemWidth: 55,
        isForce2Digits: true,
        time: isEdit ? editDate : DateTime.now(),
        onTimeChange: (time) {
          validateTime(time);
        });
  }

  // Get list of medicine names
  void loadMedNames() async {
    List<String> names = await medService.getMedicineNames();
    medList = names;
  }

  void setWater(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SetWaterGoalDialog(
        initialFrequency: frequency,
        date: _selectedDay!,
        onFrequencyChanged: (newFrequency, newReminders) {
          setState(() {
            for (Event reminder in newReminders) {
              DateTime dateKey = getNormalizedDate(_selectedDay!);
              if (events.containsKey(dateKey)) {
                events[dateKey]!.add(reminder);
              } else {
                events[dateKey] = [reminder];
              }

              debugPrint('Events after add water: $events');
            }
            frequency = newFrequency;
            _selectedEvents.value = getEventsForDay(_selectedDay!);
          });
        },
      ),
    );
  }

  void resetWaterReminderForDay(DateTime selectedDay) {
    DateTime dateKey = getNormalizedDate(selectedDay);
    debugPrint('WATER REMINDER BEFORE REMOVE IN RESET WATER -> EVENT = ${events[dateKey]!.length}');

    // Check if there are events for that day and if any are WaterReminder.
    if (events.containsKey(dateKey)) {
      List<Event> dayEvents = events[dateKey]!;
      List<int> waterRemindersHashs = dayEvents
          .where((event) => event is WaterReminder)
          .map((waterReminder) => waterReminder
              .getHash()) // Ensure each WaterReminder has a unique hash/ID.
          .toList();
      debugPrint('HASH TO REMOVE');
      // Cancel each notification for water reminders
      for (int hash in waterRemindersHashs) {
        debugPrint(hash.toString());
        LocalNotifications.cancel(hash);
      }
        // Remove all WaterReminder instances from the events list for this day.
        events[dateKey]!
            .removeWhere((event) => event is WaterReminder);
        debugPrint('WATER REMINDER IN RESET WATER -> EVENT = ${events[dateKey]!.length}');
        if (events[dateKey]!.isEmpty) {
          debugPrint('IT IS EMPTY');
          events.remove(dateKey);
        }
        setState((){
          _selectedEvents.value = getEventsForDay(dateKey);
        });

      // Log or display a message about the action taken.
      debugPrint('Water reminders reset for $dateKey.');
    } else {
      debugPrint('No water reminders to reset for $dateKey.');
    }
  }

  void addReminder(
      BuildContext context, String title, String buttonSubmit, int index) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text(title, style: TextStyle(fontSize: 18)),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    TypeAheadField<String>(
                      controller: medicineController,
                      suggestionsCallback: (pattern) async {
                        if (pattern.isNotEmpty) {
                          return medList
                              .where((name) => name
                                  .toLowerCase()
                                  .contains(pattern.toLowerCase()))
                              .toList();
                        } else {
                          return <String>[];
                        }
                      },
                      builder: (context, controller, focusNode) => Form(
                          key: formNameKey,
                          child: TextFormField(
                              controller: medicineController,
                              onChanged: (value) {
                                formNameKey.currentState?.validate();
                              },
                              onTapOutside: (event) {
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              focusNode: focusNode,
                              autofocus: false,
                              decoration: InputDecoration(
                                  hintText: 'Medicine',
                                  hintStyle: const TextStyle(
                                      fontSize: 16, color: Colors.black87),
                                  errorText: error.value),
                              validator: (value) {
                                return validateName();
                              })),
                      onSelected: (medName) {
                        medicineController.text = medName.trim();
                        medicineController.selection =
                            TextSelection.fromPosition(
                          TextPosition(offset: medicineController.text.length),
                        );
                      },
                      itemBuilder: (context, medName) {
                        return ListTile(title: Text(medName));
                      },
                      hideOnEmpty: true,
                    ),
                    const Spacer(),
                    DoseFormSelector(
                      doseFormNotifier: ValueNotifier(currentDoseForm),
                      onDoseFormChanged: (doseForm) {
                        currentDoseForm = doseForm;
                        validateDose(currentDoseForm);
                      },
                    ),
                    ValueListenableBuilder<String?>(
                      valueListenable: doseError,
                      builder: (context, value, child) {
                        debugPrint(doseError.value);
                        return doseError.value != null
                            ? Text('${doseError.value}',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.red[800]))
                            : const SizedBox();
                      },
                    ),
                    ExpansionTile(
                        tilePadding: EdgeInsets.zero,
                        title: const Text(
                          'Time',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500),
                        ),
                        onExpansionChanged: (bool expanded) {
                          setState(() {
                            _isExpanded = expanded;
                          });
                        },
                        trailing: ValueListenableBuilder<TimeOfDay>(
                          valueListenable: timeNotifier,
                          builder: (context, value, child) {
                            return Text(
                              value.format(context),
                              style: const TextStyle(fontSize: 16),
                            );
                          },
                        ),
                        children: <Widget>[
                          showTimePicker(context),
                        ]),
                    ValueListenableBuilder<String?>(
                      valueListenable: errorTimeNotifier,
                      builder: (context, value, child) {
                        return errorTimeNotifier.value != null
                            ? Text('${errorTimeNotifier.value}',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.red[800]))
                            : const SizedBox();
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      medicineController.clear();
                      timeNotifier.value = TimeOfDay.now();
                      error.value = null;
                      errorTimeNotifier.value = null;
                      doseError.value = null;
                      currentDoseForm = 'Select Form';
                      isEdit = false;
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel')),
                ElevatedButton(
                    onPressed: () {
                      // Store the context before the async operation
                      final localContext = context;
                      if (formNameKey.currentState!.validate() &&
                          errorTimeNotifier.value == null &&
                          doseError.value == null) {
                        Event newEvent = MedicineReminder(
                            medicine: medicineController.text,
                            dose: currentDoseForm,
                            date: DateTime(
                                _selectedDay!.year,
                                _selectedDay!.month,
                                _selectedDay!.day,
                                timeNotifier.value.hour,
                                timeNotifier.value.minute,
                                _selectedDay!.second + DateTime.now().second),
                            time: TimeOfDay(
                                hour: timeNotifier.value.hour,
                                minute: timeNotifier.value.minute));

                        debugPrint('new event added = ${newEvent.serialize()}');
                        if (buttonSubmit == 'Save') {
                          debugPrint('SAVE TAP WITH INDEX = $index');
                          // Update current event
                          updateReminder(context, index, newEvent);
                        } else {
                          // Add event to local list
                          addEventsForDate(newEvent);

                          // Schedule reminder to notify
                          LocalNotifications.scheduleNotification(
                              event: newEvent);
                        }
                      } else {
                        // Validate dose.
                        validateDose(currentDoseForm);

                        return;
                      }
                      // Reset the time notifier
                      timeNotifier.value = TimeOfDay.now();

                      // Clear dose form
                      currentDoseForm = 'Select Form';

                      // Clear fields
                      medicineController.clear();
                      // Get events in a day to display
                      _selectedEvents.value = getEventsForDay(_selectedDay!);

                      // Close the dialog
                      Navigator.of(localContext).pop();
                    },
                    child: Text(buttonSubmit))
              ]);
        });
  }

  // Edit Reminder
  void editReminder(BuildContext context, int index, Event event) {
    setState(() {
      editDate = event.date;
      debugPrint('edit date = ${event.date}');
      medicineController.text =
          event is MedicineReminder ? event.medicine : 'empty';
      timeNotifier.value = event.time;
      debugPrint('event time = ${timeNotifier.value}');
      currentDoseForm = event is MedicineReminder ? event.dose : 'Select Form';
      isEdit = true;
    });

    addReminder(context, 'Edit Reminder', 'Save', index);
  }

  // Update reminder in a specific date.
  void updateReminder(BuildContext context, int index, Event event) {
    DateTime dateKey = getNormalizedDate(event.date);
    debugPrint('EVENTS[$dateKey][$index] = ${events[dateKey]![index]}');
    Event existingEvent = events[dateKey]![index];
    LocalNotifications.cancel(existingEvent.getHash());
    events[dateKey]![index] = event;
    LocalNotifications.scheduleNotification(event: event);
    _selectedEvents.value = getEventsForDay(getNormalizedDate(event.date));
    isEdit = false;

    debugPrint('LENGTH = ${events[getNormalizedDate(event.date)]?.length}');
    debugPrint('LENGTH LIST = ${events.length}');
  }

  // Delete the reminder
  void deleteRedminer(BuildContext context, DateTime date, Event event) {
    setState(() {
      events[date]?.remove(event);
      // Check if there's no event in a day, remove the date out of the map.
      if (events[date]?.length == 0) {
        events.remove(date);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocNotificationListener<NotificationBloc, NotificationState,
        MyNotifications>(
      notificationListener: (context, notification) {
        if (notification is UpdateNotificationPageIndex) {
          debugPrint('THIS IS BLOC FROM MED_SCHEDULE');
        }
      },
      child: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
        for (var event in state.events) {
          removeEventFromSchedule(event);
        }
        ;
        return Scaffold(resizeToAvoidBottomInset: true, body: content());
      }),
    );
  }

  Widget content() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TableCalendar(
            formatAnimationDuration: const Duration(milliseconds: 275),
            formatAnimationCurve: Curves.easeInOutSine,
            locale: "en_US",
            daysOfWeekHeight: 30,
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              leftChevronVisible: false,
              rightChevronVisible: false,
              headerMargin: EdgeInsets.only(left: 17),
            ),
            calendarBuilders:
                CalendarBuilders(markerBuilder: (context, date, events) {
              if (events.isNotEmpty) {
                return Positioned(
                    bottom: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: waterMode
                            ? Colors.lightBlue
                            : Theme.of(context).primaryColor,
                      ),
                      width: 6.0,
                      height: 6.0,
                    ));
              }
            }, singleMarkerBuilder: (context, date, event) {
              return Container(
                alignment: Alignment.center,
                height: 5.0,
                width: 5.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: waterMode
                      ? Colors.lightBlue
                      : Theme.of(context).primaryColor,
                ),
              );
            }, todayBuilder: (context, date, event) {
              return Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: waterMode
                        ? Color(0XFFA9E5FF)
                        : Theme.of(context).colorScheme.primaryContainer,
                    shape:
                        BoxShape.circle, // Circular shape for the selected day
                  ),
                  child: Center(
                    child: Text(
                      date.day.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ));
            }, selectedBuilder: (context, date, events) {
              if (!isSameDay(date, today)) {
                return Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: waterMode
                              ? Colors.lightBlue
                              : Theme.of(context).primaryColor,
                          width: 2), // Custom color for the selected day
                      shape: BoxShape
                          .circle, // Circular shape for the selected day
                    ),
                    child: Center(
                      child: Text(
                        date.day.toString(),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ));
              } else {
                return Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: waterMode
                          ? Colors.lightBlue
                          : Theme.of(context).primaryColor,
                      shape: BoxShape
                          .circle, // Circular shape for the selected day
                    ),
                    child: Center(
                      child: Text(
                        date.day.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ));
              }
            }, headerTitleBuilder: (context, focusedDay) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${focusedDay.year}",
                    style:
                        const TextStyle(fontSize: 13.0, color: Colors.black45),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat.MMMM().format(focusedDay),
                        style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            height: 0.0),
                      ),
                      IconButton(
                        onPressed: formatChanged,
                        icon: _buttonDropDown,
                      ),
                      IconButton(
                        icon: const Icon(UniconsLine.focus),
                        onPressed: toToday,
                      ),
                      const Spacer(),
                      // Water mode button
                      InkWell(
                        onTap: () {
                          debugPrint(
                              'water with state water mode = ${waterMode}');
                          setState(() {
                            waterMode = !waterMode;
                            if (waterMode == true) {
                              // Show deleted message
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                backgroundColor: Colors.lightBlue,
                                content: Text('Water Reminder ON.'),
                                duration: Duration(milliseconds: 500),
                              ));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                backgroundColor: Theme.of(context).primaryColor,
                                content: const Text('Water Reminder OFF.'),
                                duration: const Duration(milliseconds: 500),
                              ));
                            }
                          });
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: waterMode
                                ? Colors.lightBlue
                                : Colors
                                    .transparent, // Change the background color based on waterMode
                            borderRadius: BorderRadius.circular(
                                20), // Optional: Add rounded corners
                          ),
                          padding: const EdgeInsets.all(
                              8), // Optional: Adjust padding for visual spacing around the icon
                          child: Icon(
                            UniconsLine.tear,
                            size: 25,
                            color: waterMode ? Colors.white : Colors.lightBlue,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      FloatingActionButton.small(
                          backgroundColor: waterMode
                              ? Colors.lightBlue
                              : Theme.of(context).colorScheme.primaryContainer,
                          onPressed: () async {
                            requestNotificationPermission();
                            var status = await Permission.notification.status;
                            if (status.isGranted) {
                              debugPrint('TAP DATE ${_selectedDay}');
                              DateTime selected = DateTime(_selectedDay!.year,
                                  _selectedDay!.month, _selectedDay!.day);
                              DateTime thisMoment =
                                  DateTime(today.year, today.month, today.day);

                              if (selected.isAfter(thisMoment) ||
                                  selected.isAtSameMomentAs(thisMoment)) {
                                if (waterMode == false) {
                                  // medicine mode
                                  // Medicine Reminder
                                  addReminder(
                                      context, 'New Reminder', 'Add', -1);
                                } else {
                                  // water mode
                                  debugPrint('WATER MODE');
                                  DateTime normalizeSelectedDay =
                                      getNormalizedDate(_selectedDay!);
                                  if (events
                                      .containsKey(normalizeSelectedDay)) {
                                    // Retrieve the list of events for the selected day.
                                    List<Event> dayEvents =
                                        events[normalizeSelectedDay]!;

                                    // Check if there is any WaterReminder in the list of events for this day.
                                    bool hasWaterReminder = dayEvents
                                        .any((event) => event is WaterReminder);

                                    if (hasWaterReminder) {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text(
                                              'Reset Water Reminder'),
                                          content: const Text(
                                              'Are you sure you want to reset the water reminder for this day?'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.of(
                                                      context)
                                                  .pop(), // Close the dialog without any action.
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                resetWaterReminderForDay(
                                                    _selectedDay!);
                                                Navigator.of(context)
                                                    .pop();// Close the dialog after performing the action.
                                              },
                                              child: const Text('Reset'),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      setWater(context);
                                      //Navigator.of(context).pop();
                                    }
                                  } else {
                                    setWater(context);
                                  }
                                }
                              } else {
                                // Show deleted message
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  backgroundColor: waterMode
                                      ? Colors.lightBlue
                                      : Theme.of(context).primaryColor,
                                  content: Text('Invalid date.'),
                                  duration: const Duration(seconds: 2),
                                ));
                              }
                            } else {
                              // do nothing until the user turns on the  notification
                            }
                          },
                          child: Icon(UniconsLine.plus,
                              color:
                                  waterMode ? Colors.white : Colors.black87)),
                      const SizedBox(width: 10)
                    ],
                  ),
                ],
              );
            }),
            daysOfWeekStyle: const DaysOfWeekStyle(
                decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black12, // The color of the border
                  width: 1.0, // The width of the border
                ),
              ),
            )),
            availableGestures: AvailableGestures.all,
            availableCalendarFormats: const {
              CalendarFormat.month: 'Month',
              CalendarFormat.week: 'Week'
            },
            calendarFormat: _format,
            onFormatChanged: (format) => (format) {
              if (_format != format) {
                setState(() {
                  _format = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            rowHeight: 50,
            focusedDay: _focusedDay,
            firstDay: DateTime.utc(2000),
            lastDay: DateTime.utc(2050),
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: daySelected,
            eventLoader: getEventsForDay,
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  debugPrint('THIS IS VALUE LISTENER IN BUILDER');
                  debugPrint('$_selectedEvents');
                  // Filter events based on waterMode
                  List<Event> filteredEvents = waterMode
                      ? value.where((event) => event is WaterReminder).toList()
                      : value
                          .where((event) => event is MedicineReminder)
                          .toList();

                  return ListView.builder(
                      itemCount: filteredEvents.length,
                      itemBuilder: (context, index) {
                        String id = filteredEvents[index].getID();
                        DateTime date = getNormalizedDate(value[index].date);
                        return Dismissible(
                            key: Key(id),
                            direction: DismissDirection.endToStart,
                            confirmDismiss: (direction) async {
                              // Show confirmation dialog
                              return await showDialog<bool>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Confirm Delete',
                                            style: TextStyle(fontSize: 18.0)),
                                        content: RichText(
                                          text: TextSpan(
                                            style: const TextStyle(
                                                color: Colors
                                                    .black), // Default text style
                                            children: [
                                              const TextSpan(
                                                  text:
                                                      "Are you sure you want to delete the reminder for "),
                                              TextSpan(
                                                text: filteredEvents[index]
                                                        is MedicineReminder
                                                    ? (filteredEvents[index]
                                                            as MedicineReminder)
                                                        .medicine
                                                    : (filteredEvents[index]
                                                            is WaterReminder)
                                                        ? 'water intake'
                                                        : 'event',
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const TextSpan(text: "?"),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            onPressed: () =>
                                                Navigator.of(context)
                                                    .pop(false),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(true),
                                            child: const Text('Delete'),
                                          ),
                                        ],
                                      );
                                    },
                                  ) ??
                                  false; // Return false if the user cancels
                            },
                            onDismissed: (direction) {
                              Event removeEvent = filteredEvents[index];
                              deleteRedminer(context, date, removeEvent);

                              // Cancel the reminder in notification
                              LocalNotifications.cancel(removeEvent.getHash());
                              // Show deleted message
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                backgroundColor: Theme.of(context).primaryColor,
                                content: Text(
                                    'Deleted ${(removeEvent as MedicineReminder).medicine} reminder.'),
                                duration: const Duration(seconds: 2),
                              ));

                              // Test if the reminder is removed.
                              debugPrint(
                                  'SELECTED EVENT = ${_selectedEvents.value.length}');
                              debugPrint(
                                  'EVENT AFTER DELETE IN A DAY = ${events[date]?.length}');
                              debugPrint(
                                  'EVENTS LIST AFTER DELETE = ${events.length}');
                            },
                            background: Card(
                                color: Colors.red[100],
                                child: const Icon(UniconsLine.trash_alt,
                                    color: Colors.white, size: 35)),
                            dismissThresholds: const {
                              DismissDirection.endToStart: 0.1
                            },
                            child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 4),
                                child: Card(
                                  margin: const EdgeInsets.all(5.0),
                                  child: ListTile(
                                    onTap: () {
                                      if (waterMode == false) {
                                        // medicine mode
                                        editReminder(
                                            context, index, filteredEvents[index]);
                                        debugPrint(
                                            'dose = ${(value[index] as MedicineReminder).dose}');
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          backgroundColor: Colors.lightBlue,
                                          content: Text(
                                              "You cannot edit water reminder once it's set."),
                                          duration: Duration(seconds: 1),
                                        ));
                                      }
                                    },
                                    leading: Icon(
                                        filteredEvents[index]
                                                is MedicineReminder
                                            ? MedicineFormHelper.getIconByDose(
                                                (filteredEvents[index]
                                                        as MedicineReminder)
                                                    .dose)
                                            : UniconsLine.tear,
                                        size: 30.0),
                                    title: Text(
                                      filteredEvents[index] is MedicineReminder
                                          ? '${(filteredEvents[index] as MedicineReminder).getMedicine()}'
                                          : 'Drink ${(filteredEvents[index] as WaterReminder).amount} ounces',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        height:
                                            1.5, // Adjust line spacing to preference
                                      ),
                                    ),
                                    trailing: Text(
                                      '${filteredEvents[index].getTime(context)}',
                                      style: const TextStyle(
                                        fontSize:
                                            14.0, // Adjust line spacing to preference
                                      ),
                                    ),
                                  ),
                                )));
                      });
                }),
          ),
        ]);
  }
}
