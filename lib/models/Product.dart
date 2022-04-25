// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';
import 'dart:ffi';

import 'package:reuseapp/models/User.dart';

import 'Brand.dart';
import 'Category.dart';
import 'Image.dart';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    this.id,
    this.title,
    this.description,
    this.price,
    this.images,
    this.categoryId,
    this.category,
    this.brandId,
    this.brand,
    this.sellerAccountId,
    this.sellerAccount,
    this.updated,
    this.success,
    this.message,
  });

  int? id;
  String? title;
  String? description;
  double? price;
  List<Image>? images;
  int? categoryId;
  Category? category;
  int? brandId;
  Brand? brand;
  int? sellerAccountId;
  User? sellerAccount;
  DateTime? updated;
  bool? success;
  String? message;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        price: json["price"] ?? 0,
        images: json["images"] == null
            ? <Image>[]
            : List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        categoryId: json["categoryId"],
        category: Category.fromJson(json["category"]),
        brandId: json["brandId"],
        brand: Brand.fromJson(json["brand"]),
        sellerAccountId: json["sellerAccountId"],
        sellerAccount: User.fromJson(json["sellerAccount"]),
        updated: DateTime.parse(json["updated"]),
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
        "categoryId": categoryId,
        "category": category?.toJson(),
        "brandId": brandId,
        "brand": brand?.toJson(),
        "sellerAccountId": sellerAccountId,
        "sellerAccount": sellerAccount,
        "updated": updated?.toIso8601String(),
        "success": success,
        "message": message,
      };
}
