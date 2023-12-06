class Employee {
  int id;
  String email;
  String password;
  String username;
  String name;
  String role;
  int clinicAccount;
  String address;
  String contactNo;
  String age;
  String sex;
  String profilePicture;
  String? about;

  Employee({
    required this.id,
    required this.email,
    required this.password,
    required this.username,
    required this.name,
    required this.role,
    required this.clinicAccount,
    required this.address,
    required this.contactNo,
    required this.age,
    required this.sex,
    required this.profilePicture,
    required this.about,
  });
  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["ID"],
        email: json["EMAIL"],
        password: json["PASSWORD"],
        username: json["USERNAME"],
        name: json["NAME"],
        role: json["ROLE"],
        clinicAccount: json["CLINIC_ACCOUNT"],
        address: json["ADDRESS"],
        contactNo: json["CONTACT_NO"],
        age: json["AGE"],
        sex: json["SEX"],
        profilePicture: json["PROFILE_PICTURE"],
        about: json["ABOUT"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "EMAIL": email,
        "PASSWORD": password,
        "USERNAME": username,
        "NAME": name,
        "ROLE": role,
        "CLINIC_ACCOUNT": clinicAccount,
        "ADDRESS": address,
        "CONTACT_NO": contactNo,
        "AGE": age,
        "SEX": sex,
        "PROFILE_PICTURE": profilePicture,
        "ABOUT": about,
      };
}

class Clinics {
  int id;
  String email;
  String username;
  String password;
  String? bio;
  String? picture;
  String? name;
  Clinics({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.bio,
    required this.picture,
    required this.name,
  });

  factory Clinics.fromJson(Map<String, dynamic> json) => Clinics(
        id: json["ID"],
        email: json["EMAIL"],
        username: json["USERNAME"],
        password: json["PASSWORD"],
        bio: json["BIO"],
        picture: json["PICTURE"],
        name: json["NAME"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "EMAIL": email,
        "USERNAME": username,
        "PASSWORD": password,
        "BIO": bio,
        "PICTURE": picture,
        "NAME": name,
      };
}
