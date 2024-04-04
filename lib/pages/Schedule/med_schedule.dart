import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:unicons/unicons.dart';

import '../../firebase/services.dart';
import 'event.dart';

class MedicationSchedule extends StatefulWidget {
  const MedicationSchedule({super.key});

  @override
  State<MedicationSchedule> createState() => _MedicationScheduleState();
}

class _MedicationScheduleState extends State<MedicationSchedule>
    with SingleTickerProviderStateMixin {
  DataService medService = DataService();
  DateTime today = DateTime.now();
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _format = CalendarFormat.month;
  Icon _buttonDropDown = const Icon(UniconsLine.angle_up);

  bool _isExpanded = false;
  TimeOfDay timeSelected = TimeOfDay.now();
  late ValueNotifier<TimeOfDay> timeNotifier;

  // Store the events created
  Map<DateTime, List<Event>> events = {};
  TextEditingController medicineController = TextEditingController();
  //TextEditingController dose = TextEditingController();
  late ValueNotifier<List<Event>> _selectedEvents;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(getEventsForDay(_selectedDay!));
    timeNotifier = ValueNotifier(timeSelected);
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

  void toToday() {
    setState(() {
      _focusedDay = DateTime.now();
      _selectedDay = DateTime.now();
    });
  }

  List<Event> getEventsForDay(DateTime date) {
    return events[getNormalizedDate(date)] ?? [];
  }

  bool inputValid() {
    if (medicineController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Invalid input!'), duration: Duration(seconds: 2)));
      return false;
    }
    return true;
  }

  void addEventsForDate(DateTime date, String medicine, TimeOfDay time) {
    if (events[getNormalizedDate(date)] != null) {
      //print('Events in $date day is not null');
      events[getNormalizedDate(date)]?.add(
        Event(
            //dose: int.parse(dose.text),
            medicine: medicine,
            date: getNormalizedDate(date),
            time: time),
      );
    } else {
      //print(events[getNormalizedDate(date)]?.length);
      events[getNormalizedDate(date)] = [
        Event(medicine: medicine, date: getNormalizedDate(date), time: time
            //dose: int.parse(dose.text),
            )
      ];
    }
  }

  TimePickerSpinner showTimePicker(BuildContext context) {
    return TimePickerSpinner(
      alignment: Alignment.center,
      is24HourMode: false,
      normalTextStyle:
          const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
      highlightedTextStyle:
          TextStyle(fontSize: 25, color: Theme.of(context).primaryColor),
      spacing: 18,
      itemHeight: 60,
      itemWidth: 55,
      isForce2Digits: true,
      onTimeChange: (time) {
        timeNotifier.value = TimeOfDay.fromDateTime(time);
        timeSelected = timeNotifier.value;
      },
    );
  }

  Future<List<String>> medNames() async {
    List<String> names = await medService.getMedicineNames();
    return names;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: content(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AlertDialog(
                      title: const Text('New Reminder',
                          style: TextStyle(fontSize: 18)),
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
                              builder: (context, controller, focusNode) =>
                                  TextField(
                                      controller: medicineController,
                                      focusNode: focusNode,
                                      autofocus: true,
                                      decoration: const InputDecoration(
                                          hintText: 'Medicine',
                                          hintStyle: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black87))),
                              onSelected: (medName) {
                                medicineController.text = medName.trim();
                                medicineController.selection =
                                    TextSelection.fromPosition(
                                  TextPosition(
                                      offset: medicineController.text.length),
                                );
                              },
                              itemBuilder: (context, medName) {
                                return ListTile(title: Text(medName));
                              },
                              hideOnEmpty: true,
                            ),
                            const Spacer(),
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
                                children: <Widget>[showTimePicker(context)]),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              medicineController.clear();
                              timeNotifier.value = TimeOfDay.now();
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel')),
                        ElevatedButton(
                            onPressed: () {
                              if (inputValid()) {
                                addEventsForDate(
                                    _selectedDay!,
                                    medicineController.text,
                                    timeNotifier.value);
                              } else {
                                return;
                              }
                              //dose.clear();
                              medicineController.clear();
                              Navigator.of(context).pop();
                              _selectedEvents.value =
                                  getEventsForDay(_selectedDay!);
                            },
                            child: const Text("Add"))
                      ]);
                });
          },
          child: const Icon(UniconsLine.plus)),
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
                        color: Theme.of(context)
                            .primaryColor,
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
                      const Spacer(),
                      IconButton(
                        icon: const Icon(UniconsLine.focus),
                        onPressed: toToday,
                      ),
                      IconButton(
                        icon: const Icon(UniconsLine.edit),
                        onPressed: () {
                          print('Edit button tapped');
                        },
                      ),
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
                        return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black26),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: ListTile(
                              onTap: () => print(value.length),
                              title: Text(
                                '${value[index].getMedicine()}\n'
                                '${DateFormat('MM.dd.yy').format(value[index].getDateTime())}\n'
                                '${value[index].getTime(context)}',
                                style: TextStyle(
                                  height:
                                      1.5, // Adjust line spacing to preference
                                ),
                              ),
                            ));
                      });
                }),
          )
        ]);
  }
}
