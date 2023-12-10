import 'dart:convert';

import 'package:flutter_application_1/models/clinic_profiles.dart';
import 'package:flutter_application_1/models/services_offered.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../config/config.dart';

class TherapistController {
  Future<Employee> getTherapist() async {
    late SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('employeeToken');
    Map<String, dynamic> payload = JwtDecoder.decode(token!);

    var response = await http.get(
        Uri.parse("$baseUrl$getEmployeeUrl${payload['ID']}"),
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
              about: json["ABOUT"],
            ))
        .toList();
    return objects[0];
  }

  Future<List<Employee>> getFreelanceTherapist() async {
    var response = await http.get(Uri.parse("$baseUrl$getFreelanceUrl"),
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
              about: json["ABOUT"],
            ))
        .toList();
    return objects;
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

  Future<List<Services>> getSelectedServices() async {
    late SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('employeeToken');
    Map<String, dynamic> payload = JwtDecoder.decode(token!);
    var response = await http.get(
        Uri.parse("$baseUrl$getSelectedServicesUrl${payload['ID']}"),
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

  Future<List<Services>> getSoloServices(int id) async {
    var response = await http.get(
        Uri.parse("$baseUrl$getSelectedServicesUrl$id"),
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
    var response = await http.patch(Uri.parse("$baseUrl$saveServicesUrl$id"),
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
}
