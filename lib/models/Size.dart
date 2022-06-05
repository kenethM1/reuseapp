import 'dart:convert';

import 'package:equatable/equatable.dart';

SizeCloth sizeFromJson(String str) => SizeCloth.fromJson(json.decode(str));

String sizeToJson(SizeCloth data) => json.encode(data.toJson());

class SizeCloth extends Equatable {
  SizeCloth({
    required this.sizeId,
    required this.size,
  });

  int sizeId;
  String size;

  factory SizeCloth.fromJson(Map<String, dynamic> json) => SizeCloth(
        sizeId: json["sizeId"],
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "sizeId": sizeId,
        "size": size,
      };

  @override
  List<Object?> get props => [sizeId, size];
}
