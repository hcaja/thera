import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      "profile": 1
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
}
