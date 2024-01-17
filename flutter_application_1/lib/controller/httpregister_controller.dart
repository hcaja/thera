import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/config.dart';
import 'package:http/http.dart' as http;

class ClinicRegisterApi {
  late SharedPreferences prefs;
  Future<bool> clinicRegister(
      String clinicName,
      String userName,
      String email,
      String contactNumber,
      String address,
      String password,
      String passwordConfirm,
      String profilePic,
      String fileAttatchment) async {
    prefs = await SharedPreferences.getInstance();
    var reqBody = {
      "username": userName,
      "email": email,
      "password": password,
      "name": clinicName,
      "picture": profilePic
    };
    var response = await http.post(Uri.parse(baseUrl + clinicRegisterUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (jsonResponse['access'] != null) {
        Map<String, dynamic> payload =
            JwtDecoder.decode(jsonResponse['access']);
        uploadAttatchments(fileAttatchment, payload['ID'], 'clinic');
        Fluttertoast.showToast(
            msg: "Registration Complete, Please wait for approval",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
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

  Future<bool> clinicTherapistRegister(
    String role,
    String name,
    String email,
    String password,
    String address,
    String contact,
    String age,
    String sex,
    String profilePic,
    String username,
    String fileAtt,
  ) async {
    prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('clinicToken');
    Map<String, dynamic> payload = JwtDecoder.decode(token!);
    var reqBody = {
      "ROLE": role,
      "NAME": name,
      "email": email,
      "password": password,
      "CLINIC_ACCOUNT": payload['ID'],
      "ADDRESS": address,
      "CONTACT_NO": contact,
      "AGE": age,
      "SEX": sex,
      "PROFILE_PICTURE": profilePic,
      "username": username,
    };
    var response = await http.post(
        Uri.parse(baseUrl + clinicTherapistRegisterUrl),
        headers: {"Content-Type": "application/json", "token": token},
        body: jsonEncode(reqBody));
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (jsonResponse['access'] != null) {
        Map<String, dynamic> payload =
            JwtDecoder.decode(jsonResponse['access']);
        uploadAttatchments(fileAtt, payload['ID'], 'therapist');
        Fluttertoast.showToast(
            msg: "Account Created",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
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

  Future<bool> soloTherapistRegister(
    String name,
    String email,
    String password,
    String address,
    String contact,
    String age,
    String sex,
    String username,
    String profilePicLink,
    String fileAtt,
  ) async {
    var reqBody = {
      "ROLE": "1",
      "NAME": name,
      "email": email,
      "password": password,
      "ADDRESS": address,
      "CONTACT_NO": contact,
      "AGE": age,
      "SEX": sex,
      "PROFILE_PICTURE": profilePicLink,
      "username": username,
    };
    var response = await http.post(
        Uri.parse(baseUrl + soloTherapistRegisterUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (jsonResponse['access'] != null) {
        Map<String, dynamic> payload =
            JwtDecoder.decode(jsonResponse['access']);
        uploadAttatchments(fileAtt, payload['ID'], 'therapist');
        Fluttertoast.showToast(
            msg: "Account Created",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
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

  Future<bool> parentRegister(
    String fullname,
    String username,
    String email,
    String contact,
    String address,
    String password,
    String profilePicLink,
    String fileAtt,
  ) async {
    var reqBody = {
      "FULLNAME": fullname,
      "username": username,
      "email": email,
      "CONTACT_NUMBER": contact,
      "ADDRESS": address,
      "password": password,
    };
    var response = await http.post(Uri.parse(baseUrl + parentRegisterUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));

    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (jsonResponse['access'] != null) {
        Map<String, dynamic> payload =
            JwtDecoder.decode(jsonResponse['access']);
        uploadAttatchments(fileAtt, payload['ID'], 'parent');
        Fluttertoast.showToast(
            msg: "Account Created",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
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

  void uploadAttatchments(String fileAtt, int owner, String designation) async {
    var reqBody = {
      designation: owner,
      "file": fileAtt,
    };
    String url = '';
    if (designation == 'parent') {
      url = parentFiles;
    } else if (designation == 'therapist') {
      url = therapistFiles;
    } else if (designation == 'clinic') {
      url = clinicFiles;
    }
    await http.post(Uri.parse(baseUrl + url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));
  }
}
