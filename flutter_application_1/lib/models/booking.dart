import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/clinic_profiles.dart';
import 'package:intl/intl.dart';

class DailyTimeSlot {
  DateTime date;
  List<TimeData> timeslot;

  DailyTimeSlot({
    required this.date,
    required this.timeslot,
  });

  Map<DateTime, List<TimeData>> toMap() {
    return {date: timeslot};
  }

  factory DailyTimeSlot.fromJson(Map<String, dynamic> json) => DailyTimeSlot(
        date: DateFormat('yyyy-MM-ddTHH:mm:ss')
            .parse(json["DATE"], true)
            .toLocal(),
        timeslot: List<TimeData>.from(
            json["TIMESLOT"].map((x) => TimeData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "DATE":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "TIMESLOT": List<dynamic>.from(timeslot.map((x) => x.toJson())),
      };
}

class TimeData {
  int? id;
  int? clinic;
  DateTime? date;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  Map<String, dynamic> toJson() {
    return {
      'clinic': clinic,
      'date': DateFormat('yyyy-MM-dd HH:mm:ss').format(date!),
      'start_time': convertToSqlTime(startTime!),
      'end_time': convertToSqlTime(endTime!),
    };
  }

  static TimeOfDay _parseTimeOfDay(String timeString) {
    List<String> parts = timeString.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }

  factory TimeData.fromJson(Map<String, dynamic> json) {
    return TimeData(
      id: json['ID'],
      clinic: json['CLINIC'],
      date: DateTime.parse(json['DATE']),
      startTime: _parseTimeOfDay(json['START_TIME']),
      endTime: _parseTimeOfDay(json['END_TIME']),
    );
  }

  String convertToSqlTime(TimeOfDay flutterTime) {
    // Extract hours and minutes from TimeOfDay
    int hours = flutterTime.hour;
    int minutes = flutterTime.minute;

    // Format the time as a string
    String formattedTime = '$hours:${minutes.toString().padLeft(2, '0')}:00';

    return formattedTime;
  }

  TimeData.empty();

  TimeData.raw({
    required this.date,
    required this.startTime,
    required this.endTime,
  });

  TimeData({
    this.id,
    this.clinic,
    required this.date,
    required this.startTime,
    required this.endTime,
  });
}

class Parent {
  int? id;
  String? email;
  String? username;
  String? contactNumber;
  String? note;
  String? address;
  String? fullname;

  Parent({
    required this.id,
    required this.email,
    required this.username,
    required this.contactNumber,
    required this.note,
    required this.address,
    required this.fullname,
  });

  factory Parent.fromJson(Map<String, dynamic> json) => Parent(
        id: json["ID"],
        email: json["EMAIL"],
        username: json["USERNAME"],
        contactNumber: json["CONTACT_NUMBER"],
        note: json["NOTE"],
        address: json["ADDRESS"],
        fullname: json["FULLNAME"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "EMAIL": email,
        "USERNAME": username,
        "CONTACT_NUMBER": contactNumber,
        "NOTE": note,
        "ADDRESS": address,
        "FULLNAME": fullname,
      };
}

class Appointment {
  int? id;
  Parent? parent;
  DateTime? datebooked;
  TimeData? timeslot;
  Clinics? clinic;
  Employee? therapist;
  int? status;
  String? note;

  Appointment({
    required this.id,
    required this.parent,
    required this.datebooked,
    required this.timeslot,
    required this.clinic,
    required this.therapist,
    required this.status,
    this.note,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
      id: json["ID"],
      parent: Parent.fromJson(json["PARENT"]),
      datebooked: DateTime.parse(json["DATEBOOKED"]),
      timeslot: TimeData.fromJson(json["TIMESLOT"]),
      clinic: Clinics.fromJson(json["CLINIC"]),
      therapist: Employee.fromJson(json['THERAPIST']),
      status: json["STATUS"],
      note: json["NOTE"]);

  Map<String, dynamic> toJson() => {
        "ID": id,
        "PARENT": parent!.id,
        "TIMESLOT": timeslot!.id,
        "CLINIC": clinic!.id,
        "THERAPIST": therapist!.id,
        "STATUS": status,
        "NOTE": note,
      };
}
