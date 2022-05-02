import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class UploadImageController extends GetxController {
  var images = <Asset>[].obs;
  var isLoading = false.obs;
  var isUploading = false.obs;

  Future<Image> GetImage(Asset asset) async {
    final ByteData byteData = await asset.getByteData();

    final Image image = Image.memory(byteData.buffer.asUint8List());

    return image;
  }

  Future<List<Image>> GetImages() async {
    List<Image> imagesList = [];
    for (var asset in images.value) {
      final ByteData byteData = await asset.getByteData();

      final Image image =
          Image.memory(byteData.buffer.asUint8List(), fit: BoxFit.cover);

      imagesList.add(image);
    }
    return imagesList;
  }

  bool anyImage() {
    return images.value.isNotEmpty;
  }
}
