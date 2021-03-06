class Image {
  Image({
    this.id,
    this.url,
    this.productId,
  });

  int? id;
  String? url;
  int? productId;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"] ?? 0,
        url: json["url"] ?? "",
        productId: json["productId"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "productId": productId,
      };

  static toList(List<String> urlsUploaded) {
    var images = <Map<String, dynamic>>[];
    for (var url in urlsUploaded) {
      images.add({
        "url": url,
      });
    }
    return images;
  }
}
