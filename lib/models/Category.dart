// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category extends Equatable {
  Category({
    this.id,
    this.title,
    this.imageUrl,
    this.description,
    this.success,
    this.message,
  });

  int? id;
  String? title;
  String? imageUrl;
  String? description;
  bool? success;
  String? message;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        title: json["title"],
        imageUrl: json["imageUrl"],
        description: json["description"],
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "imageUrl": imageUrl,
        "description": description,
        "success": success,
        "message": message,
      };

  static Future<List<Category>> fromJsonList(json) {
    return json != null
        ? json.map<Category>((item) => Category.fromJson(item)).toList()
        : null;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, title];
}
