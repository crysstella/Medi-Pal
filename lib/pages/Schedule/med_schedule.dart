import 'package:bloc_notification/bloc_notification.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:medipal/pages/Schedule/dose.dart';
import 'package:notification_repository/notification_repository.dart';
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
  TextEditingController medicineController = TextEditingController();
  late ValueNotifier<List<Event>> _selectedEvents;
  late ValueNotifier<String?> error;
  late ValueNotifier<String?> errorTimeNotifier;
  final formNameKey = GlobalKey<FormState>();

  // Listen to edit reminder
  bool isEdit = false;
  DateTime? editDate;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(getEventsForDay(_selectedDay!));
    timeNotifier = ValueNotifier(timeSelected);
    error = ValueNotifier(null);
    errorTimeNotifier = ValueNotifier(null);
    doseError = ValueNotifier(null);
    tz.initializeTimeZones();
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
    if (_selectedDay!.isAfter(time)) {
      setState(() {
        errorTimeNotifier.value = null;
        timeNotifier.value = TimeOfDay.fromDateTime(time);
        timeSelected = timeNotifier.value;
      });
    } else {
      if (time.isBefore(DateTime.now().add(Duration(minutes: 1)))) {
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
      //print('Events in $date day is not null');
      events[getNormalizedDate(newEvent.date)]?.add(newEvent);
    } else {
      //print(events[getNormalizedDate(date)]?.length);
      events[getNormalizedDate(newEvent.date)] = [newEvent];
    }
  }

  void removeEventFromSchedule(Event targetEvent) {
    // Iterate over each date and its associated events
    for (DateTime date in events.keys) {
      // Look for the event in the list of events for this date
      events[date]?.removeWhere((event) => event.id == targetEvent.id);
      // If no events are left for this date, also remove the date key
      if (events[date]?.isEmpty ?? true) {
        events.remove(date);
      }
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
  Future<List<String>> medNames() async {
    List<String> names = await medService.getMedicineNames();
    return names;
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
                          List<String> names =
                              await medService.getMedicineNames();
                          return names
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
                        print(doseError.value);
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
                        Event newEvent = Event(
                            medicine: medicineController.text,
                            dose: currentDoseForm,
                            date: DateTime(
                                _selectedDay!.year,
                                _selectedDay!.month,
                                _selectedDay!.day,
                                timeNotifier.value.hour,
                                timeNotifier.value.minute),
                            time: TimeOfDay(
                                hour: timeNotifier.value.hour,
                                minute: timeNotifier.value.minute));

                        print('new event added = ${newEvent.serialize()}');
                        if (buttonSubmit == 'Save') {
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
      print('edit date = ${event.date}');
      medicineController.text = event.medicine;
      timeNotifier.value = event.time;
      print('event time = ${timeNotifier.value}');
      currentDoseForm = event.dose;
      isEdit = true;
    });

    addReminder(context, 'Edit Reminder', 'Save', index);
  }

  // Update reminder in a specific date.
  void updateReminder(BuildContext context, int index, Event event) {
    setState(() {
      events[getNormalizedDate(event.date)]?[index] = event;
      isEdit = false;
    });
    print('LENGTH = ${events[getNormalizedDate(event.date)]?.length}');
    print('LENGTH LIST = ${events.length}');
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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: content(),
    );
  }

  Widget content() {
    return BlocNotificationListener<NotificationBloc, NotificationState,
            MyNotifications>(
        notificationListener: (context, notification) {
          if (notification is UpdateNotificationPageIndex) {
            final state = BlocProvider.of<NotificationBloc>(context).state;
            print('THIS IS BLOC FROM MED_SCHEDULE');
            setState(() {
              for (var event in state.events) {
                removeEventFromSchedule(event);
              }
            });
          }
        },
        child: Column(
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
                            color: Theme.of(context).primaryColor,
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
                      color: Theme.of(context).primaryColor,
                    ),
                  );
                }, selectedBuilder: (context, date, events) {
                  if (!isSameDay(date, today)) {
                    return Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).primaryColor,
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
                  }
                }, headerTitleBuilder: (context, focusedDay) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "${focusedDay.year}",
                        style: const TextStyle(
                            fontSize: 13.0, color: Colors.black45),
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
                          FloatingActionButton.small(
                              onPressed: () {
                                addReminder(context, 'New Reminder', 'Add', -1);
                              },
                              child: const Icon(UniconsLine.plus)),
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
                      return ListView.builder(
                          itemCount: value.length,
                          itemBuilder: (context, index) {
                            String id = value[index].getID();
                            DateTime date =
                                getNormalizedDate(value[index].date);
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
                                                style:
                                                    TextStyle(fontSize: 18.0)),
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
                                                    text: value[index].medicine,
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
                                                    Navigator.of(context)
                                                        .pop(true),
                                                child: const Text('Delete'),
                                              ),
                                            ],
                                          );
                                        },
                                      ) ??
                                      false; // Return false if the user cancels
                                },
                                onDismissed: (direction) {
                                  Event removeEvent = value[index];
                                  deleteRedminer(context, date, removeEvent);

                                  // Cancel the reminder in notification
                                  LocalNotifications.cancel(
                                      removeEvent.getHash());
                                  // Show deleted message
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    content: Text(
                                        'Deleted ${removeEvent.medicine} reminder.'),
                                    duration: const Duration(seconds: 2),
                                  ));

                                  // Test if the reminder is removed.
                                  print(
                                      'SELECTED EVENT = ${_selectedEvents.value.length}');
                                  print(
                                      'EVENT AFTER DELETE IN A DAY = ${events[date]?.length}');
                                  print(
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
                                          editReminder(
                                              context, index, value[index]);
                                          print('dose = ${value[index].dose}');
                                        },
                                        leading: Icon(
                                            MedicineFormHelper.getIconByDose(
                                                value[index].dose),
                                            size: 30.0),
                                        title: Text(
                                          '${value[index].getMedicine()}',
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            height:
                                                1.5, // Adjust line spacing to preference
                                          ),
                                        ),
                                        trailing: Text(
                                          '${value[index].getTime(context)}',
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
            ]));
  }
}
