import 'package:equatable/equatable.dart';

class Brand extends Equatable {
  Brand({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [id, name];
}
