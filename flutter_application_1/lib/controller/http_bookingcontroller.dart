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
    Map<String, dynamic> payload = JwtDecoder.decode(token!);

    var response = await http.get(
        Uri.parse("$baseUrl$getTimeDataUrl${payload['ID']}"),
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
