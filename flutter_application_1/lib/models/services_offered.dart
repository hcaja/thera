class Services {
  int id;
  String desc;

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'DESC': desc,
    };
  }

  Services({
    required this.id,
    required this.desc,
  });
}
