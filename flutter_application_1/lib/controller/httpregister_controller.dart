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
    String fullName,
    String userName,
    String email,
    String contactNumber,
    String address,
    String password,
    String passwordConfirm,
  ) async {
    prefs = await SharedPreferences.getInstance();
    var reqBody = {
      "username": userName,
      "email": email,
      "password": password,
    };
    var response = await http.post(Uri.parse(baseUrl + clinicRegisterUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (jsonResponse['access'] != null) {
        Fluttertoast.showToast(
            msg: "Registration Complete, Please wait for aproval",
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
  ) async {
    prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('clinicToken');
    Map<String, dynamic> payload = JwtDecoder.decode(token!);
    var reqBody = {
      "ROLE": role,
      "NAME": name,
      "email": email,
      "password": password,
      "CLINIC_ACCOUNT": payload['ID'], //TODO
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
}
