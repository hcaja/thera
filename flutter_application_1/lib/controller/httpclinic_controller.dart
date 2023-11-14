import 'dart:convert';

import 'package:flutter_application_1/models/booking.dart';
import 'package:flutter_application_1/models/clinic_profiles.dart';
import 'package:flutter_application_1/models/services_offered.dart';
import 'package:http/http.dart' as http;

import '../config/config.dart';

class ClinicController {
  Future<List<Clinics>> getClinics() async {
    var response = await http.get(Uri.parse("$baseUrl$getClinicsUrl"),
        headers: {"Content-Type": "application/json"});

    final List<dynamic> jsonData = json.decode(response.body);
    List<Clinics> objects = jsonData
        .map((json) => Clinics(
              id: json["ID"],
              email: json["EMAIL"],
              username: json["USERNAME"],
              password: json["PASSWORD"],
              bio: json["BIO"],
              picture: json["PICTURE"],
              name: json["NAME"],
            ))
        .toList();
    return objects;
  }

  Future<Clinics> getClinic(int id) async {
    var response = await http.get(Uri.parse("$baseUrl$getClinicUrl$id"),
        headers: {"Content-Type": "application/json"});

    final List<dynamic> jsonData = json.decode(response.body);

    List<Clinics> objects = jsonData
        .map((json) => Clinics(
              id: json["ID"],
              email: json["EMAIL"],
              username: json["USERNAME"],
              password: json["PASSWORD"],
              bio: json["BIO"],
              picture: json["PICTURE"],
              name: json["NAME"],
            ))
        .toList();
    return objects[0];
  }

  Future<List<Services>> getServices() async {
    var response = await http.get(Uri.parse("$baseUrl$getServicesUrl"),
        headers: {"Content-Type": "application/json"});

    final List<dynamic> jsonData = json.decode(response.body);

    List<Services> objects = jsonData
        .map((json) => Services(
              id: json["ID"],
              desc: json["DESC"],
            ))
        .toList();
    return objects;
  }

  Future<List<Services>> getSelectedServices(int id) async {
    var response = await http.get(
        Uri.parse("$baseUrl$getClinicSelectedServicesUrl$id"),
        headers: {"Content-Type": "application/json"});

    final List<dynamic> jsonData = json.decode(response.body);

    List<Services> objects = jsonData
        .map((json) => Services(
              id: json["ID"],
              desc: json["DESC"],
            ))
        .toList();

    return objects;
  }

  Future<bool> saveServices(int id, List<Services> services) async {
    Map<String, dynamic> requestBody = {
      'servList': services.map((service) => service.toJson()).toList(),
    };
    //print(reqBody);
    var response = await http.patch(
        Uri.parse("$baseUrl$saveClinicServicesUrl$id"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> saveabout(int id, String about) async {
    var reqBody = {
      "about": about,
    };
    //print(reqBody);
    var response = await http.patch(Uri.parse("$baseUrl$saveAboutUrl$id"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<Map<DateTime, List<TimeData>>> getTimeData(int id) async {
    var response = await http.get(Uri.parse("$baseUrl$getTimeDataUrl$id"),
        headers: {"Content-Type": "application/json"});

    final List<dynamic> responseData = json.decode(response.body);

    List<DailyTimeSlot> dailyTimeSlots = [];

    for (var data in responseData) {
      final DateTime date = DateTime.parse(data['DATE']);

      final List<TimeData> timeslot = List<TimeData>.from(
        data['TIMESLOT'].map((slot) => TimeData.fromJson(slot)),
      );

      dailyTimeSlots.add(DailyTimeSlot(date: date, timeslot: timeslot));
    }

    Map<DateTime, List<TimeData>> combinedMap = {};

    for (var dailyTimeSlot in dailyTimeSlots) {
      Map<DateTime, List<TimeData>> timeSlotMap = dailyTimeSlot.toMap();

      // Merge the current timeSlotMap into the combinedMap
      timeSlotMap.forEach((date, timeslot) {
        if (combinedMap.containsKey(date)) {
          combinedMap[date]!.addAll(timeslot);
        } else {
          combinedMap[date] = List.from(timeslot);
        }
      });
    }
    return combinedMap;
  }
}
