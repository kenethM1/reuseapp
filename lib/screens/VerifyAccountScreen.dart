import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reuseapp/screens/LoginScreen.dart';
import 'package:reuseapp/utils/colors.dart';
import 'package:reuseapp/utils/resourses/appButtonsResourses.dart';
import 'package:reuseapp/utils/translationsHelper.dart';

import '../controllers/language_controller.dart';
import '../controllers/verifyAccountController.dart';
import '../utils/resourses/AppFontsResourses.dart';

class VerifyAccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var translate = TranslationHelper();
    var phoneScreen = MediaQuery.of(context).size;
    var verificationAccountController =
        Get.put<VerifyAccountController>(VerifyAccountController());
    var languageController = Get.put<LanguageController>(LanguageController());
    var titlesResourses = AppFontsResourses();

    return Scaffold(
        backgroundColor: ColorsApp.primary,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  ColorsApp.primary,
                  ColorsApp.primary,
                ],
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              height: phoneScreen.height * 0.85,
              width: phoneScreen.width * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LanguagesSelector(languageController: languageController),
                  Text(translate.getTranslated('verify_account'),
                      style: titlesResourses.titles),
                  Text(
                    translate.getTranslated('verify_account_description'),
                    style: titlesResourses.description,
                  ),
                  Container(
                    width: phoneScreen.width * 0.6,
                    height: 100,
                    child: Obx(
                      () => TextField(
                        expands: true,
                        maxLines: null,
                        strutStyle: const StrutStyle(
                          forceStrutHeight: true,
                        ),
                        onChanged: (value) =>
                            verificationAccountController.codeValue = value,
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ColorsApp.secondary,
                          fontSize:
                              titlesResourses.secondaryText.fontSize! * 1.0,
                        ),
                        textInputAction: TextInputAction.send,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          label: Center(
                            heightFactor: 1.0,
                            child: Text(
                              translate.getTranslated('code'),
                              style: titlesResourses.secondaryText.copyWith(
                                fontSize:
                                    titlesResourses.secondaryText.fontSize! *
                                        1.5,
                              ),
                            ),
                          ),
                          labelStyle: titlesResourses.secondaryText.copyWith(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      verificationAccountController.verifyAccount(context);
                    },
                    child: Text(translate.getTranslated('verify')),
                    style: AppButtonsResourses().secundarybutton,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
