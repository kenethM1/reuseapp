import 'package:get/get.dart';
import 'package:reuseapp/controllers/language_controller.dart';
import 'package:reuseapp/utils/resourses/translationsResourse.dart';

class TranslationHelper {
  LanguageController languageController =
      Get.put<LanguageController>(LanguageController());

  String getSelectedLanguage() {
    return languageController.languageCode;
  }

  String getTranslated(String key) {
    return TranslationResourse().translations[getSelectedLanguage()]![key] ??
        key;
  }
}
