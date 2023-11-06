import 'dart:convert';

import 'package:flutter_application_1/models/clinic_profiles.dart';
import 'package:http/http.dart' as http;

import '../config/config.dart';

class ClinicController {
  Future<List<Clinics>> getClinics() async {
    var response = await http.get(Uri.parse("$baseUrl$getClinicsUrl"),
        headers: {"Content-Type": "application/json"});

    final List<dynamic> jsonData = json.decode(response.body);
    print(response.body);
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
}
