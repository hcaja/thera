import 'dart:convert';

ClinicMaterial clinicMaterialFromJson(String str) =>
    ClinicMaterial.fromJson(json.decode(str));

String clinicMaterialToJson(ClinicMaterial data) => json.encode(data.toJson());

class ClinicMaterial {
  int id;
  String title;
  String desc;
  int type;
  String file;

  ClinicMaterial({
    required this.id,
    required this.title,
    required this.desc,
    required this.type,
    required this.file,
  });

  factory ClinicMaterial.fromJson(Map<String, dynamic> json) => ClinicMaterial(
        id: json["ID"],
        title: json["TITLE"],
        desc: json["DESC"],
        type: json["TYPE"],
        file: json["FILE"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "TITLE": title,
        "DESC": desc,
        "TYPE": type,
        "FILE": file,
      };
}
