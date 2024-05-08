import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

class Event{
  String id;
  final String medicine;
  final String dose;
  final DateTime date;
  final TimeOfDay time;

  //final int dose;
  Event({
    required this.medicine,
    required this.dose,
    required this.date,
    required this.time,
    String? id,
  }) : id = id ?? Uuid().v4();

  String getID() => id;

  String getMedicine() => medicine;

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

  // Convert an Event object into a Map object
  Map<String, dynamic> toJson() => {
    'id': id,
    'medicine': medicine,
    'dose': dose,
    'date': date.toIso8601String(), // Convert DateTime to String
    'time': '${time.hour}:${time.minute}', // Convert TimeOfDay to String
  };

  // Serialize Event object to a JSON string
  String serialize() => jsonEncode(toJson());

  // Factory constructor to create an Event from a JSON string
  factory Event.deserialize(String source) {
    Map<String, dynamic> data = jsonDecode(source);
    return Event(
      id: data['id'],
      medicine: data['medicine'],
      date: DateTime.parse(data['date']),
      dose: data['dose'],
      time: TimeOfDay(
          hour: int.parse(data['time'].split(':')[0]),
          minute: int.parse(data['time'].split(':')[1])),
    );
  }


}