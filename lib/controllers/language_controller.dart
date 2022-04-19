import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../utils/resourses/languages_available.dart';

class LanguageController extends GetxController {
  var _languageCode = 'es'.obs;

  String get languageCode => _languageCode.value;
  Map<String, Map<String, String>> get availablesLanguage =>
      LanguagesAvailable().lenguages;

  void printLanguages() {
    availablesLanguage.forEach((key, value) {
      debugPrint('$key: $value');
    });
  }

  set languageCode(String value) {
    _languageCode.value = value;
    update();
  }
}
