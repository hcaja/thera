import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/clinic_profiles.dart';
import 'package:flutter_application_1/screens/auth/login_profiles.dart';
import 'package:flutter_application_1/screens/clinic/clinic_profile.dart';
import 'package:flutter_application_1/screens/parent/dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './config.dart';

class ClinicLogin {
  late SharedPreferences prefs;
  Future<void> clinicLogin(BuildContext context, username, password) async {
    prefs = await SharedPreferences.getInstance();
    var reqBody = {"email": username, "password": password};
    var response = await http.post(Uri.parse(baseUrl + clinicLoginUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['access'] != null) {
      var myToken = jsonResponse['access'];
      prefs.setString('clinicToken', myToken);

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const LoginProfile(),
        ),
      );
    } else {
      print('login failed');
    }
  }

  Future<List<Employee>> getProfiles(BuildContext context, int clinicID) async {
    prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('clinicToken');
    Map<String, dynamic> payload = JwtDecoder.decode(token!);
    var response = await http.get(
        Uri.parse("$baseUrl$getProfilesUrl/${payload['ID']}"),
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
            ))
        .toList();

    return objects;
  }
}

class EmployeeLogin {
  late SharedPreferences prefs;
  Future<void> employeeLogin(BuildContext context, username, password) async {
    prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('clinicToken');
    var reqBody = {"email": username, "password": password};
    var response = await http.post(Uri.parse(baseUrl + employeeLoginUrl),
        headers: {"Content-Type": "application/json", "token": token!},
        body: jsonEncode(reqBody));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      if (jsonResponse['access'] != null) {
        var myToken = jsonResponse['access'];
        prefs.setString('employeeToken', myToken);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const Dashboard(),
          ),
        );
      } else {
        print(response.statusCode);
      }
    } else {
      print(response.statusCode);
    }
  }
}

class Validator {
  late SharedPreferences prefs;
  Future<bool> validateToken(String token) async {
    prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('clinicToken');

    var response = await http.get(Uri.parse(baseUrl + tokenValidator),
        headers: {"Content-Type": "application/json", "token": token!});

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
