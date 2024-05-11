import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Event extends Equatable{
  final int hashCode;
  final String id;
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
    int? hashCode
  }) : id = id ?? Uuid().v4(),
        this.hashCode = hashCode ?? Object.hash(medicine, dose, date, time);

  String getID() => id;

  String getMedicine() => medicine;

  int getHash() => hashCode;

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
      date.second
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

  @override
  List<Object?> get props => [id, medicine, dose, date, time];


}
