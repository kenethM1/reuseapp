import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reuseapp/utils/colors.dart';
import 'package:reuseapp/utils/translationsHelper.dart';

import '../controllers/verifyAccountController.dart';
import '../utils/resourses/AppFontsResourses.dart';

class VerifyAccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var translate = TranslationHelper();
    var phoneScreen = MediaQuery.of(context).size;
    var verificationAccountController =
        Get.put<VerifyAccountController>(VerifyAccountController());
    var titlesResourses = AppFontsResourses();

    return Scaffold(
        body: Container(
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
        child: Column(
          children: [
            Text(translate.getTranslated('verify_account'),
                style: titlesResourses.titles),
            Row(
              children: [
                Container(
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
                  width: 100,
                  height: 100,
                  child: Obx(
                    () => TextField(
                      controller: verificationAccountController.codeController,
                      onChanged: (value) =>
                          verificationAccountController.codeValue = value,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: translate.getTranslated('code'),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    verificationAccountController.verifyAccount(context);
                  },
                  child: Text(translate.getTranslated('verify')),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
