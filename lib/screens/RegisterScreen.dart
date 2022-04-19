import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reuseapp/controllers/language_controller.dart';
import 'package:reuseapp/controllers/register_controller.dart';
import 'package:reuseapp/screens/LoginScreen.dart';
import 'package:reuseapp/utils/colors.dart';
import 'package:reuseapp/utils/resourses/appButtonsResourses.dart';
import 'package:reuseapp/utils/resourses/appFontsResourses.dart';

import '../utils/translationsHelper.dart';

class RegisterAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var translate = TranslationHelper();
    var phoneScreen = MediaQuery.of(context).size;
    var titlesResourses = AppFontsResourses();
    var registerController = Get.put<RegisterController>(RegisterController());
    var languageController = Get.find<LanguageController>();
    return Scaffold(
        body: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: phoneScreen.width,
          minHeight: phoneScreen.height,
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ColorsApp.primary,
                ColorsApp.secondary,
              ],
            ),
          ),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              height: phoneScreen.height * 0.85,
              width: phoneScreen.width * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  LanguagesSelector(languageController: languageController),
                  Obx(() => Text(translate.getTranslated('register_account'),
                      style: titlesResourses.titles)),
                  Form(
                    child: Column(
                      children: [
                        Obx(() => TextFormField(
                              decoration: InputDecoration(
                                  errorText: registerController
                                          .emailErrorText.value.isEmpty
                                      ? null
                                      : registerController.emailErrorText.value,
                                  icon: Icon(Icons.email,
                                      color: ColorsApp.primary),
                                  labelText: translate.getTranslated('email'),
                                  labelStyle: titlesResourses.secondaryText),
                              onChanged: (value) => registerController
                                  .emailControllerValue = value,
                            )),
                        Obx(() => TextFormField(
                              decoration: InputDecoration(
                                  suffix: IconButton(
                                    icon: Icon(Icons.remove_red_eye,
                                        color: registerController
                                                .canSeePassword.isTrue
                                            ? ColorsApp.primary
                                            : Colors.red),
                                    onPressed: () => registerController
                                            .canSeePassword.value =
                                        !registerController
                                            .canSeePassword.value,
                                  ),
                                  icon: Icon(
                                      registerController
                                              .passwordErrorText.isEmpty
                                          ? Icons.lock
                                          : Icons.lock_open,
                                      color: ColorsApp.primary),
                                  errorText: registerController
                                          .passwordErrorText.value.isEmpty
                                      ? null
                                      : registerController
                                          .passwordErrorText.value,
                                  labelText:
                                      translate.getTranslated('password'),
                                  labelStyle: titlesResourses.secondaryText),
                              obscureText:
                                  registerController.canSeePassword.value,
                              maxLength: 12,
                              onChanged: (value) =>
                                  registerController.passwordValue = value,
                            )),
                        Obx(() => TextFormField(
                              decoration: InputDecoration(
                                  icon: const Icon(Icons.person,
                                      color: Colors.white, size: 30),
                                  labelText:
                                      translate.getTranslated('first_name'),
                                  labelStyle: titlesResourses.secondaryText),
                              controller:
                                  registerController.firstNameController,
                            )),
                        Obx(() => TextFormField(
                              decoration: InputDecoration(
                                  icon: Icon(Icons.person,
                                      color: ColorsApp.primary, size: 30),
                                  labelText:
                                      translate.getTranslated('last_name'),
                                  labelStyle: titlesResourses.secondaryText),
                              controller: registerController.lastNameController,
                            )),
                        Obx(() => CheckboxListTile(
                              title: Text(
                                  translate.getTranslated('accept_terms'),
                                  style: titlesResourses.secondaryText
                                      .copyWith(fontSize: 13)),
                              value: registerController.acceptTerms.value,
                              selectedTileColor: ColorsApp.secondary,
                              activeColor: ColorsApp.secondary,
                              onChanged: (value) {
                                registerController.acceptTerms.value =
                                    value ?? false;
                              },
                            )),
                        SizedBox(height: 20),
                        Obx(() => ElevatedButton(
                              style: AppButtonsResourses().primaryButton,
                              child: Text(translate.getTranslated('register'),
                                  style: titlesResourses.secondaryText
                                      .copyWith(color: Colors.white),
                                  textAlign: TextAlign.center),
                              onPressed: () {
                                registerController.tryRegister(context);
                              },
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
