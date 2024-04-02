import 'package:flutter/material.dart';

class Event{
  final String medicine;
  final DateTime date;
  final TimeOfDay time;

  //final int dose;
  Event({required this.medicine,
    /*required this.dose, */
    required this.date,
    required this.time
  });

  String getMedicine(){
    return medicine;
  }

  String getTime(context){
    return time.format(context);
  }

  DateTime getDateTime() {
    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }


}