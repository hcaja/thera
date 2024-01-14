import 'dart:convert';

ClinicMaterial clinicMaterialFromJson(String str) =>
    ClinicMaterial.fromJson(json.decode(str));

String clinicMaterialToJson(ClinicMaterial data) => json.encode(data.toJson());

class ClinicMaterial {
  int? id;
  String title;
  String desc;
  int? clinic;
  List<MaterialFile>? files;
  String thumbnail;

  ClinicMaterial({
    this.id,
    required this.title,
    required this.desc,
    this.clinic,
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
        "id": id,
        "title": title,
        "desc": desc,
        "clinic": clinic,
        "thumbnail": thumbnail,
      };
}

class MaterialFile {
  int? id;
  int? material;
  String type;
  String file;
  String? title;

  MaterialFile({
    this.id,
    this.material,
    this.title,
    required this.type,
    required this.file,
  });

  factory MaterialFile.fromJson(Map<String, dynamic> json) => MaterialFile(
      id: json["ID"],
      material: json["MATERIAL"],
      type: json["TYPE"],
      file: json["FILE"],
      title: json['TITLE']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "material": material,
        "type": type,
        "file": file,
        "title": title
      };
}

Checklist checklistFromJson(String str) => Checklist.fromJson(json.decode(str));

String checklistToJson(Checklist data) => json.encode(data.toJson());

class Checklist {
  int id;
  int parent;
  String? journal;
  String? picture;
  String? checklist;
  bool checked;
  int clinic;

  Checklist({
    required this.id,
    required this.parent,
    required this.journal,
    required this.picture,
    required this.checklist,
    required this.checked,
    required this.clinic,
  });

  factory Checklist.fromJson(Map<String, dynamic> json) => Checklist(
        id: json["ID"],
        parent: json["PARENT"],
        journal: json["JOURNAL"],
        picture: json["PICTURE"],
        checklist: json["CHECKLIST"],
        checked: json["CHECKED"],
        clinic: json["CLINIC"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "PARENT": parent,
        "JOURNAL": journal,
        "PICTURE": picture,
        "CHECKLIST": checklist,
        "CHECKED": checked,
        "CLINIC": clinic,
      };
}
