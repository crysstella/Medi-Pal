import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

abstract class Event extends Equatable {
  final int hash;
  final String id;
  final DateTime date;
  final TimeOfDay time;

  Event({required this.date, required this.time, String? id, int? hash})
      : this.id = id ?? Uuid().v4(),
        this.hash = hash ?? Object.hash(id, date, time);

  @override
  List<Object?> get props => [id, date, time];

  String getID() => id;

  int getHash() => hash;

  String getTime(context) {
    return time.format(context);
  }

  DateTime getDateTime() {
    return DateTime(
        date.year, date.month, date.day, time.hour, time.minute, date.second);
  }

  Map<String, dynamic> toJson();

  String serialize() => jsonEncode(toJson());

  static TimeOfDay timeFromString(String timeStr) {
    final parts = timeStr.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  static Event deserialize(String source) {
    Map<String, dynamic> data = jsonDecode(source);
    // Based on the 'type' field, determine which subclass to instantiate
    switch (data['type']) {
      case 'medicine':
        return MedicineReminder.deserialize(source);
      case 'water':
        // Assuming you have a WaterReminder class
        return WaterReminder.deserialize(source);
      default:
        throw Exception("Unsupported event type");
    }
  }
}

class MedicineReminder extends Event {
  final String medicine;
  final String dose;

  MedicineReminder({
    required this.medicine,
    required this.dose,
    required DateTime date,
    required TimeOfDay time,
    String? id,
  }) : super(date: date, time: time, id: id);

  @override
  List<Object?> get props => super.props + [medicine, dose];

  String getMedicine() => medicine;

  String getTitle() => 'Medicine Reminder';

  String getBody() => 'Time to take ${this.medicine} - ${this.dose}.';

  @override
  Map<String, dynamic> toJson() => {
        'type': 'medicine',
        'id': id,
        'medicine': medicine,
        'dose': dose,
        'date': date.toIso8601String(),
        'time': '${time.hour}:${time.minute}',
      };

  factory MedicineReminder.deserialize(String source) {
    final data = jsonDecode(source);
    return MedicineReminder(
      id: data['id'],
      medicine: data['medicine'],
      dose: data['dose'],
      date: DateTime.parse(data['date']),
      time: Event.timeFromString(data['time']),
    );
  }
}

class WaterReminder extends Event {
  final int amount; // in ounces
  final int frequency;
  final TimeOfDay wakeUpTime;
  final TimeOfDay sleepTime;

  WaterReminder({
    required this.amount,
    required DateTime date,
    required TimeOfDay time,
    required this.frequency,
    required this.wakeUpTime,
    required this.sleepTime,
    String? id,
  }) : super(date: date, time: time, id: id);

  @override
  List<Object?> get props => super.props + [amount];

  @override
  Map<String, dynamic> toJson() => {
        'type': 'water',
        'id': id,
        'frequency': frequency,
        'amount': amount,
        'date': date.toIso8601String(),
        'time': '${time.hour}:${time.minute}',
        'wakeUpTime': '${wakeUpTime.hour}:${wakeUpTime.minute}',
        'sleepTime': '${sleepTime.hour}:${sleepTime.minute}'
      };

  String getTitle() => 'Water Reminder';

  String getBody() => 'Time to drink ${this.amount} ml of water.';

  factory WaterReminder.deserialize(String source) {
    final data = jsonDecode(source);
    return WaterReminder(
      id: data['id'],
      amount: data['amount'],
      frequency: data['frequency'],
      date: DateTime.parse(data['date']),
      time: Event.timeFromString(data['time']),
      wakeUpTime: Event.timeFromString(data['wakeUpTime']),
      sleepTime: Event.timeFromString(data['sleepTime']),
    );
  }
}

/*
class Water extends Equatable{
  final int hashCode;
  final String id;
  final int amount;
  final DateTime date;
  final TimeOfDay time;

  //final int dose;
  Water({
    required this.amount,
    required this.date,
    required this.time,
    String? id,
    int? hashCode
  }) : this.id = id ?? Uuid().v4(),
        this.hashCode = hashCode ?? Object.hash(amount, date, time);

  String getID() => id;

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
    'hashCode': hashCode,
    'id': id,
    'amount': amount,
    'date': date.toIso8601String(), // Convert DateTime to String
    'time': '${time.hour}:${time.minute}', // Convert TimeOfDay to String
  };

  // Serialize Event object to a JSON string
  String serialize() => jsonEncode(toJson());

  // Factory constructor to create an Event from a JSON string
  factory Water.deserialize(String source) {
    Map<String, dynamic> data = jsonDecode(source);
    return Water(
      id: data['id'],
      amount: data['amount'],
      date: DateTime.parse(data['date']),
      time: TimeOfDay(
          hour: int.parse(data['time'].split(':')[0]),
          minute: int.parse(data['time'].split(':')[1])),
    );
  }

  @override
  List<Object?> get props => [hashCode, id, amount, date, time];


}

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
  }) : this.id = id ?? Uuid().v4(),
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
    'hashCode': hashCode,
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
  List<Object?> get props => [hashCode, id, medicine, dose, date, time];


}
*/