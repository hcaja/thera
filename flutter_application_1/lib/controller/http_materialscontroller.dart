import 'dart:convert';

import 'package:flutter_application_1/config/config.dart';
import 'package:flutter_application_1/models/materials.dart';
import 'package:http/http.dart' as http;

class MaterialsController {
  Future<List<ClinicMaterial>> getMaterials() async {
    var response = await http.get(Uri.parse("$baseUrl$getMaterialsUrl"),
        headers: {"Content-Type": "application/json"});

    final List<dynamic> jsonData = json.decode(response.body);

    List<ClinicMaterial> objects =
        jsonData.map((json) => ClinicMaterial.fromJson(json)).toList();

    return objects;
  }
}
