import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:unicons/unicons.dart';

import 'event.dart';

class MedicationSchedule extends StatefulWidget {
  const MedicationSchedule({super.key});

  @override
  State<MedicationSchedule> createState() => _MedicationScheduleState();
}

class _MedicationScheduleState extends State<MedicationSchedule>
    with SingleTickerProviderStateMixin {
  DateTime today = DateTime.now();
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _format = CalendarFormat.month;
  Icon _buttonDropDown = const Icon(UniconsLine.angle_up);

  // Store the events created
  Map<DateTime, List<Event>> events = {};
  String _title = '';
  TextEditingController title = TextEditingController();
  String _medicine = '';
  TextEditingController medicine = TextEditingController();
  //TextEditingController dose = TextEditingController();
  late final ValueNotifier<List<Event>> _selectedEvents;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(getEventsforDay(_selectedDay!));
  }

  @override
  void dispose() {
    super.dispose();
  }

  void daySelected(DateTime day, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, day)) {
      setState(() {
        _selectedDay = day;
        _focusedDay = focusedDay;
        _selectedEvents.value = getEventsforDay(day);
      });
    }
    print(_selectedDay);
    print(_focusedDay);
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

  List<Event> getEventsforDay(DateTime date) {
    return events[date] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: content(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                      title: const Text('New Reminder',
                          style: TextStyle(fontSize: 18)),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            TextField(
                              controller: title,
                              /* onChanged: (value) {
                                setState(() {
                                  _title = value;
                                });
                              },*/
                              decoration: const InputDecoration(
                                  hintText: 'Enter Title'),
                            ),
                            TextField(
                              controller: medicine,
                              /*onChanged: (value) {
                                setState(() {
                                  _medicine = value;
                                });
                              },*/
                              decoration: const InputDecoration(
                                  hintText: 'Enter Medicine'),
                            ),

                            /* TextField(
                              controller: dose,
                              decoration: const InputDecoration(
                                label: Text("Dose"),
                              ),
                            ),*/
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel')),
                        ElevatedButton(
                            onPressed: () {
                              if ((title.text.isEmpty &&
                                      /*dose.text.isEmpty||*/
                                      medicine.text.isEmpty) ||
                                  (title.text.isEmpty ||
                                      /*dose.text.isEmpty||*/
                                      medicine.text.isEmpty)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Invalid input!'),
                                        duration: Duration(seconds: 2)));
                                return;
                              } else {
                                if (events[_selectedDay!] != null) {
                                  print(_selectedDay);
                                  events[_selectedDay!]?.add(Event(
                                      title: title.text,
                                      //dose: int.parse(dose.text),
                                      medicine: medicine.text));
                                } else {
                                  events[_selectedDay!] = [
                                    Event(
                                        title: title.text,
                                        //dose: int.parse(dose.text),
                                        medicine: medicine.text)
                                  ];
                                }

                                Navigator.of(context).pop();
                                _selectedEvents.value =
                                    getEventsforDay(_selectedDay!);
                                title.clear();
                                //dose.clear();
                                medicine.clear();
                              }
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
                CalendarBuilders(selectedBuilder: (context, date, events) {
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
            eventLoader: getEventsforDay,
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
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              onTap: () => print(value.length),
                              title: Text(
                                  '${value[index].title}\n${value[index].medicine}'),
                            ));
                      });
                }),
          )
        ]);
  }
}
