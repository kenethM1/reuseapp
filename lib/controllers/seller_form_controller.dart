import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reuseapp/controllers/login_controller.dart';
import 'package:reuseapp/models/City.dart';

import '../utils/restClient.dart';

class SellerFormController extends GetxController {
  var city = ''.obs;
  var cities = <City>[].obs;
  var cityController = TextEditingController().obs;
  var dniNumber = ''.obs;
  var address = ''.obs;
  var phoneNumber = ''.obs;
  var frontDNIImage = <Asset>[].obs;
  var backDNIImage = <Asset>[].obs;
  var acceptTerms = false.obs;
  var acceptDevolutionterms = false.obs;

  Future<List<City>> getAvailableCity(String contains) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var uri = new Uri(
        scheme: 'http',
        path: '/appAvailableCities',
        queryParameters: {'contains': contains});
    var response = await restClient(
            url: "/appAvailableCities",
            uri: uri,
            method: "GET-URI",
            headers: headers)
        .execute();

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      var cities =
          List<City>.from(jsonData["data"].map((model) => City.fromMap(model)));
      if (cities.isNotEmpty) {
        this.cities.value.assignAll(cities);
        return cities;
      }
      return cities;
    }
    return [];
  }

  dynamic get(String propertyName) {
    var _mapRep = _toMap();
    if (_mapRep.containsKey(propertyName)) {
      return _mapRep[propertyName];
    }
    throw ArgumentError('propery not found');
  }

  Map<String, dynamic> _toMap() {
    return {
      'getDNIFrontImage': frontDNIImage,
      'getDNIBackImage': backDNIImage,
    };
  }

  void setCity(dynamic suggestion) {
    city.value = suggestion;
    update();
  }

  filterCity(String pattern) {
    if (pattern.isEmpty) {
      return cities.value;
    }
    return cities.value
        .where((element) => element.name.toLowerCase().contains(pattern))
        .toList();
  }

  void set(String propName, List<Asset> image) async {
    if (propName == 'getDNIFrontImage') {
      frontDNIImage.value = image;
      update();
    } else if (propName == 'getDNIBackImage') {
      backDNIImage.value = image;
      update();
    }
    update();
  }

  Future<dynamic> GetImage(String imageProp) async {
    var asset = get(imageProp).value[0];
    if (asset != null) {
      final ByteData byteData = await asset.getByteData();
      final Image image =
          Image.memory(byteData.buffer.asUint8List(), fit: BoxFit.cover);

      return image;
    }
    return null;
  }

  void pickImage(String propName, String label) async {
    var image = await MultiImagePicker.pickImages(
      maxImages: 1,
      enableCamera: true,
      selectedAssets: get(propName),
      materialOptions: MaterialOptions(
        actionBarColor: "white",
        actionBarTitle: label,
        allViewTitle: label,
        useDetailsView: false,
        selectCircleStrokeColor: "green",
        autoCloseOnSelectionLimit: true,
        startInAllView: true,
      ),
    );

    set(propName, image);
    update();
  }

  void uploadSellerForm(BuildContext context) async {
    var errorMessage = ValidateSellerForm();
    if (errorMessage.isNotEmpty) {
      showAboutDialog(
        context: context,
        children: [
          Container(
            child: Text(errorMessage),
          ),
        ],
      );
    } else {
      var headers = {
        'Content-Type': 'application/json',
      };
      var body = {
        'userId': Get.find<LoginController>().user.value.id.toString(),
        'city': cityController.value.text,
        'dni': dniNumber.value.toString(),
        'address': address.value,
        'phone': phoneNumber.value,
        'dniFront': await uploadImages('getDNIFrontImage'),
        'dniBack': await uploadImages('getDNIBackImage'),
        'acceptTerms': acceptTerms.value,
        'acceptDevolutionterms': acceptDevolutionterms.value,
      };

      debugPrint(json.encode(body));
      var response = await restClient(
              url: "/appSellerForm",
              method: "POST",
              headers: headers,
              body: body)
          .execute();

      if (response.statusCode == 200) {
        Navigator.of(context).pushNamed('homeScreen');
      } else {
        showAboutDialog(
          context: context,
          children: [
            Container(
              child: Text(response.body),
            ),
          ],
        );
      }
    }
  }

  String ValidateSellerForm() {
    var errorMessage = "";
    if (cityController.value.text.isEmpty) {
      errorMessage = "Por favor seleccione una ciudad";
    }
    if (frontDNIImage.value.isEmpty) {
      errorMessage = "Por favor seleccione una imagen de su DNI";
    }
    if (backDNIImage.value.isEmpty) {
      errorMessage = "Por favor seleccione una imagen de su DNI";
    }
    if (!acceptTerms.value) {
      errorMessage = "Por favor acepte los terminos y condiciones";
    }
    if (!acceptDevolutionterms.value) {
      errorMessage = "Por favor acepte los terminos y condiciones";
    }
    return errorMessage;
  }

  Future<String> uploadImages(String propName) async {
    List<String> urls = [];
    var images = get(propName).value;
    for (var image in images) {
      var fileImage = await getImageFileFromAssets(image);
      var uploadTask = FirebaseStorage.instance
          .ref('userDNI/${this.dniNumber}' +
              Get.find<LoginController>()
                  .user
                  .value
                  .firstName!
                  .trim()
                  .toLowerCase())
          .putFile(fileImage);

      await uploadTask.snapshot.ref.getDownloadURL().then((downloadUrl) {
        urls.add(downloadUrl);
      });
    }
    return urls.first;
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
}
