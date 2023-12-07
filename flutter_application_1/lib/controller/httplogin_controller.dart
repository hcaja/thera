import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/clinic_profiles.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/config/config.dart';

class ClinicLogin {
  late SharedPreferences prefs;
  Future<bool> clinicLogin(username, password) async {
    prefs = await SharedPreferences.getInstance();
    var reqBody = {"email": username, "password": password};
    var response = await http.post(Uri.parse(baseUrl + clinicLoginUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (jsonResponse['access'] != null) {
        var myToken = jsonResponse['access'];
        prefs.setString('clinicToken', myToken);
      }
      return true;
    } else {
      Fluttertoast.showToast(
          msg: jsonResponse,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
    }
  }

  Future<List<Employee>> getProfiles(BuildContext context, int clinic) async {
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
            about: json["ABOUT"]))
        .toList();

    return objects;
  }
}

class EmployeeLogin {
  late SharedPreferences prefs;
  Future<bool> employeeLogin(BuildContext context, username, password) async {
    prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('clinicToken');
    var reqBody = {"email": username, "password": password};
    var response = await http.post(Uri.parse(baseUrl + employeeLoginUrl),
        headers: {"Content-Type": "application/json", "token": token!},
        body: jsonEncode(reqBody));
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (jsonResponse['access'] != null) {
        var myToken = jsonResponse['access'];
        prefs.setString('employeeToken', myToken);
      }
      return true;
    } else {
      Fluttertoast.showToast(
          msg: jsonResponse,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
    }
  }

  Future<bool> soloEmployeeLogin(username, password) async {
    prefs = await SharedPreferences.getInstance();
    var reqBody = {"email": username, "password": password};
    var response = await http.post(Uri.parse(baseUrl + soloEmployeeLoginUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (jsonResponse['access'] != null) {
        var myToken = jsonResponse['access'];
        prefs.setString('employeeToken', myToken);
      }
      return true;
    } else {
      Fluttertoast.showToast(
          msg: jsonResponse,
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

class ParentLoginController {
  late SharedPreferences prefs;
  Future<bool> parentLogin(BuildContext context, username, password) async {
    prefs = await SharedPreferences.getInstance();
    var reqBody = {"email": username, "password": password};
    var response = await http.post(Uri.parse(baseUrl + parentLoginUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (jsonResponse['access'] != null) {
        var myToken = jsonResponse['access'];
        prefs.setString('parentToken', myToken);
      }
      return true;
    } else {
      Fluttertoast.showToast(
          msg: jsonResponse,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
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
            about: json["ABOUT"]))
        .toList();

    return objects;
  }
}

class Validator {
  late SharedPreferences prefs;
  Future<bool> validateToken(String token) async {
    var response = await http.get(Uri.parse(baseUrl + tokenValidator),
        headers: {"Content-Type": "application/json", "token": token});
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
