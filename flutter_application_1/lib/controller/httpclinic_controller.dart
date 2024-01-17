import 'dart:convert';

import 'package:flutter_application_1/models/booking.dart';
import 'package:flutter_application_1/models/clinic_profiles.dart';
import 'package:flutter_application_1/models/materials.dart';
import 'package:flutter_application_1/models/reviews.dart';
import 'package:flutter_application_1/models/services_offered.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<List<Clinics>> getClinicsByService(int id) async {
    var response = await http.get(
        Uri.parse("$baseUrl$getClinicsByServiceUrl$id"),
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

  Future<List<Parent>> getParentsByClinic(
    int id,
  ) async {
    var response = await http.get(Uri.parse("$baseUrl$getParentByClinicUrl$id"),
        headers: {"Content-Type": "application/json"});

    final List<dynamic> jsonData = json.decode(response.body);
    List<Parent> objects =
        jsonData.map((json) => Parent.fromJson(json)).toList();

    return objects;
  }

  Future<List<Checklist>> getChecklist(int id, int clinic) async {
    var response = await http.get(
        Uri.parse("$baseUrl$getChecklistbyParentUrl$id/$clinic"),
        headers: {"Content-Type": "application/json"});
    final List<dynamic> jsonData = json.decode(response.body);
    List<Checklist> objects =
        jsonData.map((json) => Checklist.fromJson(json)).toList();
    return objects;
  }

  Future<List<Checklist>> getChecklistByParent(int id) async {
    var response = await http.get(
        Uri.parse("$baseUrl$getChecklistbyParentUrl$id"),
        headers: {"Content-Type": "application/json"});
    final List<dynamic> jsonData = json.decode(response.body);
    List<Checklist> objects =
        jsonData.map((json) => Checklist.fromJson(json)).toList();
    return objects;
  }

  Future<bool> saveJournal(String journal, bool checked, int id) async {
    var reqBody = {
      "journal": journal,
      "checked": checked,
      "id": id,
    };

    var response = await http.put(Uri.parse("$baseUrl$saveJournalUrl"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> saveServices(int id, List<Services> services) async {
    Map<String, dynamic> requestBody = {
      'servList': services.map((service) => service.toJson()).toList(),
    };

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

  Future<bool> saveChecklist(int parent, String checklist, int clinic) async {
    var reqBody = {
      "parent": parent,
      "journal": '',
      "picture": '',
      "checklist": checklist,
      "checked": '',
      "clinic": clinic
    };

    var response = await http.post(Uri.parse("$baseUrl$saveChecklistUrl"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<Map<DateTime, List<ParentTimeData>>> getParentTimeData() async {
    late SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('parentToken');

    Map<String, dynamic> payload = JwtDecoder.decode(token!);
    var response = await http.get(
        Uri.parse("$baseUrl$getParentTimeDataUrl${payload['ID']}"),
        headers: {"Content-Type": "application/json"});

    final List<dynamic> responseData = json.decode(response.body);

    List<ParentDailyTimeSlot> dailyTimeSlots = [];

    for (var data in responseData) {
      final DateTime date = DateTime.parse(data['DATE']);

      final List<ParentTimeData> timeslot = List<ParentTimeData>.from(
        data['TIMESLOT'].map((slot) => ParentTimeData.fromJson(slot)),
      );

      dailyTimeSlots.add(ParentDailyTimeSlot(date: date, timeslot: timeslot));
    }

    Map<DateTime, List<ParentTimeData>> combinedMap = {};

    for (var dailyTimeSlot in dailyTimeSlots) {
      Map<DateTime, List<ParentTimeData>> timeSlotMap = dailyTimeSlot.toMap();

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

  Future<List<Reviews>> getReviews(int id) async {
    var response = await http.get(Uri.parse("$baseUrl$clinicReviewsURL$id"),
        headers: {"Content-Type": "application/json"});
    final List<dynamic> responseData = json.decode(response.body);
    List<Reviews> res =
        responseData.map((jsonObject) => Reviews.fromJson(jsonObject)).toList();
    return res;
  }

  Future<bool> saveReviews(int clinic, int rating, String review) async {
    late SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('parentToken');

    Map<String, dynamic> payload = JwtDecoder.decode(token!);
    var reqBody = {
      "PARENT": payload['ID'],
      "CLINIC": clinic,
      "REVIEW": review,
      "RATING": rating,
    };
    //print(reqBody);
    var response = await http.post(Uri.parse("$baseUrl$clinicAddReviewsURL"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Employee>> getProfiles(int clinicID) async {
    var response = await http.get(
        Uri.parse("$baseUrl$getProfilesUrl/$clinicID"),
        headers: {"Content-Type": "application/json"});

    final List<dynamic> jsonData = json.decode(response.body);
    List<Employee> objects = jsonData
        .map((json) => Employee(
            id: json["ID"],
            email: json["EMAIL"],
            password: json["PASSWORD"],
            username: json["USERNAME"],
            name: json["NAME"],
            role: json["ROLE"],
            clinicAccount: json["CLINIC_ACCOUNT"],
            address: json["ADDRESS"],
            contactNo: json["CONTACT_NO"],
            age: json["AGE"],
            sex: json["SEX"],
            profilePicture: json["PROFILE_PICTURE"],
            about: json["ABOUT"]))
        .toList();

    return objects;
  }
}
