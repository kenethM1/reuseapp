import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reuseapp/controllers/login_controller.dart';
import 'package:reuseapp/models/Brand.dart';
import 'package:reuseapp/utils/restClient.dart';
import 'package:http/http.dart' as http;
import 'package:reuseapp/models/Size.dart' as Size;
import 'package:reuseapp/models/Image.dart' as ImageEntity;
import 'package:reuseapp/utils/translationsHelper.dart';
import '../models/Category.dart';

class UploadImageController extends GetxController {
  var images = <Asset>[].obs;
  var isLoading = false.obs;
  var isUploading = false.obs;
  var selectedCategory = Category(id: 0, title: "Select Category").obs;
  var sizes = <Size.SizeCloth>[Size.SizeCloth(size: "", sizeId: 1)].obs;
  var selectedSize = Size.SizeCloth(size: "", sizeId: 0).obs;
  var selectedBrand = Brand().obs;
  var brands = <Brand>[Brand(id: 1, name: " ")].obs;
  var price = 0.obs;
  var productName = TextEditingController().obs;
  var productDescription = TextEditingController().obs;
  var categories = <Category>[].obs;
  set setSelectedCategory(Category? setSelectedCategory) {
    selectedCategory.value = setSelectedCategory ?? Category();
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getBrands();
    getSizes();
    getCategories();
  }

  set setSelectedSize(Size.SizeCloth? setSelectedSize) {
    selectedSize.value = setSelectedSize ?? Size.SizeCloth(size: "", sizeId: 0);
    update();
  }

  set setSelectedBrand(Brand? setSelectedBrand) {
    selectedBrand.value = setSelectedBrand ?? Brand();
    update();
  }

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

  Future<List<Size.SizeCloth>> getCategories() async {
    var headers = {
      'Content-Type': 'application/json',
    };
    http.Response response = await restClient(
            url: "/GetAllCategories", method: "GET", headers: headers)
        .execute();
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      var categories = List<Category>.from(
          jsonData.map((model) => Category.fromJson(model)));
      if (categories.isNotEmpty) {
        this.categories.value.assignAll(categories.toSet().toList());
        selectedCategory.value = categories.first;
        return sizes;
      }
      return [];
    }
    return [];
  }

  Future<List<Size.SizeCloth>> getSizes() async {
    var headers = {
      'Content-Type': 'application/json',
    };
    http.Response response =
        await restClient(url: "/GetAllSizes", method: "GET", headers: headers)
            .execute();
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      var sizes = List<Size.SizeCloth>.from(
          jsonData.map((model) => Size.SizeCloth.fromJson(model)));
      if (sizes.isNotEmpty) {
        this.sizes.value.assignAll(sizes.toSet().toList());
        selectedSize.value = sizes.first;
        return sizes;
      }
      return [];
    }
    return [];
  }

  Future<List<Brand>> getBrands() async {
    var headers = {
      'Content-Type': 'application/json',
    };
    http.Response response =
        await restClient(url: "/GetAllBrands", method: "GET", headers: headers)
            .execute();
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body)["brands"];
      var brands =
          List<Brand>.from(jsonData.map((model) => Brand.fromJson(model)));
      if (brands.isNotEmpty) {
        this.brands.assignAll(brands);
        selectedBrand.value = brands.first;
        return brands;
      }
      return [];
    }
    return [];
  }

  Future<void> addProduct(int? categoryId, BuildContext context) async {
    isUploading.value = true;
    update();
    var isOk = ValidateForm();
    if (isOk != "") {
      isUploading.value = false;
      update();
      showDialog(
          context: context,
          builder: (context) => AlertDialog(actions: [
                ElevatedButton(
                  child: Text(TranslationHelper().getTranslated("ok")),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ], title: Text(TranslationHelper().getTranslated(isOk))));
    }
    if (isOk == "") {
      var urlsUploaded = await uploadImages();
      if (urlsUploaded.isNotEmpty) {
        var headers = {
          'Content-Type': 'application/json',
        };
        var body = {
          "categoryId": categoryId,
          "brandId": selectedBrand.value.id,
          "sizeId": selectedSize.value.sizeId,
          "price": price.value,
          "title": productName.value.text,
          "description": productDescription.value.text,
          "accountId": Get.find<LoginController>().user.value.id,
          "images": ImageEntity.Image.toList(urlsUploaded),
        };
        http.Response response = await restClient(
                url: "/CreateProduct",
                method: "POST",
                headers: headers,
                body: body)
            .execute();
        if (response.statusCode == 200) {
          isUploading.value = false;
          update();
          Navigator.of(context).pop();
          CleanControllerValues();
        }
        isUploading.value = false;
        update();
      }
    }
  }

  void CleanControllerValues() {
    images.value = [];
    selectedCategory.value = Category();
    selectedBrand.value = Brand();
    selectedSize.value = Size.SizeCloth(size: "", sizeId: 0);
    price.value = 0;
    productName.value = TextEditingController();
    productDescription.value = TextEditingController();
    update();
  }

  String ValidateForm() {
    if (selectedCategory.value.id == 0) {
      return "Please select category";
    }
    if (selectedSize.value.sizeId == 0) {
      return "Please select size";
    }
    if (selectedBrand.value.id == 0) {
      return "Please select brand";
    }
    if (images.value.isEmpty) {
      return "Please select at least one image";
    }
    if (price.value == 0) {
      return "Please enter price";
    }
    if (productName.value.text.isEmpty) {
      return "Please enter product name";
    }
    if (price == 0) {
      return "Please enter price";
    }

    return "";
  }

  Future<List<String>> uploadImages() async {
    List<String> urls = [];
    for (var image in images.value) {
      var fileImage = await getImageFileFromAssets(image);
      var uploadTask = await FirebaseStorage.instance
          .ref('products/' +
              Get.find<LoginController>()
                  .user
                  .value
                  .firstName!
                  .trim()
                  .toLowerCase())
          .putFile(fileImage);

      urls.add(await uploadTask.ref.getDownloadURL());
    }
    return urls;
  }

  Future<File> getImageFileFromAssets(Asset asset) async {
    final byteData = await asset.getByteData();

    final tempFile =
        File("${(await getTemporaryDirectory()).path}/${asset.name}");
    final file = await tempFile.writeAsBytes(
      byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
    );

    return file;
  }

  void selectCategory(Category category) {
    selectedCategory.value = category;
    update();
  }
}
