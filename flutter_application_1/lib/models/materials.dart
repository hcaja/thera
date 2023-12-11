import 'dart:convert';

ClinicMaterial clinicMaterialFromJson(String str) =>
    ClinicMaterial.fromJson(json.decode(str));

String clinicMaterialToJson(ClinicMaterial data) => json.encode(data.toJson());

class ClinicMaterial {
  int id;
  String title;
  String desc;
  int clinic;
  List<MaterialFile>? files;
  String thumbnail;

  ClinicMaterial({
    required this.id,
    required this.title,
    required this.desc,
    required this.clinic,
    this.files,
    required this.thumbnail,
  });

  factory ClinicMaterial.fromJson(Map<String, dynamic> json) => ClinicMaterial(
        id: json["ID"],
        title: json["TITLE"],
        desc: json["DESC"],
        clinic: json['CLINIC'],
        files: List<MaterialFile>.from(
            json["FILES"].map((x) => MaterialFile.fromJson(x))),
        thumbnail: json["THUMBNAIL"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "TITLE": title,
        "DESC": desc,
        "THUMBNAIL": thumbnail,
      };
}

class MaterialFile {
  int id;
  int material;
  String type;
  String file;

  MaterialFile({
    required this.id,
    required this.material,
    required this.type,
    required this.file,
  });

  factory MaterialFile.fromJson(Map<String, dynamic> json) => MaterialFile(
        id: json["ID"],
        material: json["MATERIAL"],
        type: json["TYPE"],
        file: json["FILE"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "MATERIAL": material,
        "TYPE": type,
        "FILE": file,
      };
}
