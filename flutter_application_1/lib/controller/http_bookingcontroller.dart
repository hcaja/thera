import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/booking.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../config/config.dart';

class BookingController {
  late SharedPreferences prefs;

  Future<TimeData> saveTimeData(TimeData timeData) async {
    prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('clinicToken');
    Map<String, dynamic> payload = JwtDecoder.decode(token!);

    timeData.clinic = payload['ID'];

    var response = await http.post(Uri.parse(baseUrl + addTimeUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(timeData.toJson()));

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Saved",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      final Map<String, dynamic> data = json.decode(response.body);

      return TimeData.fromJson(data);
    } else {
      Fluttertoast.showToast(
          msg: response.body,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return TimeData.empty();
    }
  }

  Future<void> removeTimeData(TimeData timeData) async {
    await http.delete(Uri.parse('$baseUrl$removeTimeUrl${timeData.id}'),
        headers: {"Content-Type": "application/json"});
  }

  Future<Map<DateTime, List<TimeData>>> getTimeData() async {
    late SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('clinicToken');

    late dynamic response;

    if (token != null) {
      Map<String, dynamic> payload = JwtDecoder.decode(token);
      response = await http.get(
          Uri.parse("$baseUrl$getTimeDataUrl${payload['ID']}"),
          headers: {"Content-Type": "application/json"});
    } else {
      response = await http.get(Uri.parse("$baseUrl$getSoloTimeDataUrl${0}"),
          headers: {"Content-Type": "application/json"});
    }

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

  Future<bool> saveBooking(
    int timeslot,
    int clinic,
    int parent,
    String note,
  ) async {
    var reqBody = {
      "timeslot": timeslot,
      "clinic": clinic,
      "parent": parent,
      "therapist": 0,
      "status": 1,
      "note": note,
    };

    var response = await http.post(Uri.parse(baseUrl + saveBookingUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Saved",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      return true;
    } else {
      Fluttertoast.showToast(
          msg: response.body,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
    }
  }

  Future<Parent> getParent(int id) async {
    var response = await http.get(Uri.parse("$baseUrl$getParentUrl$id"),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<Parent> objects = jsonData
          .map((json) => Parent(
                id: json["ID"],
                email: json["EMAIL"],
                username: json["USERNAME"],
                contactNumber: json["CONTACT_NUMBER"],
                note: json["NOTE"],
                address: json["ADDRESS"],
                fullname: json["FULLNAME"],
              ))
          .toList();

      return objects[0];
    } else {
      return Parent(
        id: null,
        email: null,
        username: null,
        contactNumber: null,
        note: null,
        address: null,
        fullname: null,
      );
    }
  }

  Future<List<Appointment>> getAppointments(int id, int status) async {
    var response = await http.get(
        Uri.parse("$baseUrl$getAppointmentsUrl$id/$status"),
        headers: {"Content-Type": "application/json"});

    final List<dynamic> responseData = json.decode(response.body);

    List<Appointment> res = responseData
        .map((jsonObject) => Appointment.fromJson(jsonObject))
        .toList();
    return res;
  }

  Future<bool> acceptAppointments(int id, int thera) async {
    var response = await http.put(
        Uri.parse("$baseUrl$acceptAppointmentsUrl$id/$thera"),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Saved",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

      return true;
    } else {
      Fluttertoast.showToast(
          msg: response.body,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
    }
  }
}
