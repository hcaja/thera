import 'dart:convert';

import 'package:flutter_application_1/config/config.dart';
import 'package:flutter_application_1/models/materials.dart';
import 'package:http/http.dart' as http;

class MaterialsController {
  Future<List<ClinicMaterial>> getMaterials(int id) async {
    var response = await http.get(Uri.parse("$baseUrl$getMaterialsUrl$id"),
        headers: {"Content-Type": "application/json"});

    final List<dynamic> jsonData = json.decode(response.body);

    List<ClinicMaterial> objects =
        jsonData.map((json) => ClinicMaterial.fromJson(json)).toList();

    return objects;
  }

  Future<ClinicMaterial?> saveMaterial(ClinicMaterial clinicMaterial) async {
    var reqBody = clinicMaterial.toJson();
    print('start dbsaving');
    var response = await http.post(Uri.parse("$baseUrl$saveMaterialUrl"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody));
    print(response.reasonPhrase);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<ClinicMaterial> objects = jsonData
          .map((json) => ClinicMaterial(
                id: json["ID"],
                title: json["TITLE"],
                desc: json["DESC"],
                // clinic: json['CLINIC'],
                thumbnail: json["THUMBNAIL"],
              ))
          .toList();
      return objects[0];
    } else {
      return null;
    }
  }

  Future<bool> saveAttachment(List<MaterialFile> files) async {
    int i = files.length;
    int c = 0;
    print('start attachment db saving');

    // Use Future.wait to wait for all the futures to complete
    await Future.wait(files.map((e) async {
      var reqBody = e.toJson();
      var response = await http.post(
        Uri.parse("$baseUrl$saveAttachmentUrl"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody),
      );

      print(response.reasonPhrase);

      if (response.statusCode == 200) {
        c++;
      }
    }));

    return i == c;
  }

  Future<List<MaterialFile>> getFiles(String type) async {
    print('fetching');
    var response = await http.get(Uri.parse("$baseUrl$getAttatchmentsUrl/$type"),
        headers: {"Content-Type": "application/json"});
    print(response.reasonPhrase);
    final List<dynamic> jsonData = json.decode(response.body);

    List<MaterialFile> objects =
        jsonData.map((json) => MaterialFile.fromJson(json)).toList();

    return objects;
  }
}
