import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  TextEditingController title = TextEditingController();
  TextEditingController medicine = TextEditingController();
  TextEditingController dose = TextEditingController();
  late final ValueNotifier<List<Event>> _selectedEvents;

  /*@override
  void initState(){
    super.initState();
    ticker = createTicker((Duration elapsed) { });
  }

  @override
  void dispose(){
    ticker.dispose();
    super.dispose();
  }*/

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(getEventsforDay(_selectedDay!));
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
                      //scrollable: true,
                      title: Text("New Event"),
                      content: Container(
                          width: double.maxFinite,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Expanded(
                                  child: ListView(
                                shrinkWrap: true,
                                children: <Widget>[
                                  TextField(
                                    controller: title,
                                    decoration: InputDecoration(
                                      label: Text("Title"),
                                    ),
                                  ),
                                  TextField(
                                    controller: medicine,
                                    decoration: InputDecoration(
                                      label: Text("Medicine"),
                                    ),
                                  ),
                                  TextField(
                                    controller: dose,
                                    decoration: InputDecoration(
                                      label: Text("Dose"),
                                    ),
                                  ),
                                ],
                              ))
                            ],
                          )),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              // Store the event into the map
                              events.addAll({
                                _selectedDay!: [
                                  Event(
                                      title: title.text,
                                      dose: int.parse(dose.text),
                                      medicine: medicine.text)
                                ]
                              });
                              Navigator.of(context).pop();
                              _selectedEvents.value = getEventsforDay(_selectedDay!);
                            },
                            child: Text("Submit"))
                      ]);
                });
          },
          child: Icon(UniconsLine.plus)),
    );
  }

  Widget content() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TableCalendar(
            //pageAnimationDuration: const Duration(milliseconds: 600),
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
                        style: const TextStyle(
                            color: Colors
                                .black), // Ensure text color is consistent
                      ),
                    ));
              }
            }, headerTitleBuilder: (context, focusedDay) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center the column vertically
                crossAxisAlignment: CrossAxisAlignment
                    .start, // Align children to the start of the column
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
                      )
                    ],
                  )
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
          SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  return ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        onTap: () => print(""),
                        title: Text('${value[index].title}'),
                      )
                    );
                  });
                }),
          )
        ]);
  }
}
