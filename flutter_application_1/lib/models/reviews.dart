// To parse this JSON data, do
//
//     final reviews = reviewsFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_application_1/models/booking.dart';
import 'package:flutter_application_1/models/clinic_profiles.dart';

List<Reviews> reviewsFromJson(String str) =>
    List<Reviews>.from(json.decode(str).map((x) => Reviews.fromJson(x)));

String reviewsToJson(List<Reviews> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Reviews {
  int? id;
  Parent parent;
  Clinics clinic;
  String review;
  int rating;
  DateTime date;

  Reviews({
    this.id,
    required this.parent,
    required this.clinic,
    required this.review,
    required this.rating,
    required this.date,
  });

  factory Reviews.fromJson(Map<String, dynamic> json) => Reviews(
        id: json["ID"],
        parent: Parent.fromJson(json['PARENT']),
        clinic: Clinics.fromJson(json["CLINIC"]),
        review: json["REVIEW"],
        rating: json["RATING"],
        date: DateTime.parse(json['DATE']),
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "PARENT": parent.id,
        "CLINIC": clinic.id,
        "REVIEW": review,
        "RATING": rating,
      };
}
