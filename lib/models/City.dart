// To parse this JSON data, do
//
//     final city = cityFromMap(jsonString);

import 'dart:convert';

City cityFromMap(String str) => City.fromMap(json.decode(str));

String cityToMap(City data) => json.encode(data.toMap());

class City {
  City({
    required this.name,
    required this.country,
  });

  String name;
  String country;

  factory City.fromMap(Map<String, dynamic> json) => City(
        name: json["name"],
        country: json["country"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "country": country,
      };
}
