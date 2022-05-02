import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:reuseapp/models/User.dart';
import 'package:reuseapp/utils/colors.dart';
import 'package:reuseapp/utils/resourses/FormFieldResourses.dart';
import 'package:reuseapp/utils/resourses/appButtonsResourses.dart';
import 'package:reuseapp/utils/restClient.dart';
import 'package:reuseapp/utils/translationsHelper.dart';

import '../controllers/language_controller.dart';
import '../controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginCtrl = Get.put<LoginController>(LoginController());
    final languageController =
        Get.put<LanguageController>(LanguageController());
    final phoneScreen = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: ColorsApp.primary,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: phoneScreen.width,
              minHeight: phoneScreen.height,
            ),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [ColorsApp.primary, ColorsApp.primary],
                ),
              ),
              child: LoginBox(
                  phoneScreen: phoneScreen,
                  loginCtrl: loginCtrl,
                  languageController: languageController),
            ),
          ),
        ));
  }
}

class LoginBox extends StatelessWidget {
  const LoginBox({
    Key? key,
    required this.phoneScreen,
    required this.loginCtrl,
    required this.languageController,
  }) : super(key: key);

  final Size phoneScreen;
  final LoginController loginCtrl;
  final LanguageController languageController;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GetBuilder<LanguageController>(builder: (_) {
        return LanguagesSelector(languageController: languageController);
      }),
      Container(
        width: phoneScreen.width * 0.8,
        height: phoneScreen.height * 0.76,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 10),
              blurRadius: 5,
            ),
          ],
          border: Border.all(
            color: Colors.white,
            width: 10,
          ),
        ),
        child:
            LoginStates(loginCtrl: loginCtrl, languageCtrl: languageController),
      ),
    ]);
  }
}

class LanguagesSelector extends StatelessWidget {
  const LanguagesSelector({
    Key? key,
    required this.languageController,
  }) : super(key: key);

  final LanguageController languageController;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: languageController.availablesLanguage.entries
            .map((e) => InkWell(
                  splashColor: ColorsApp.primary,
                  focusColor: ColorsApp.primary,
                  child: e.value["flag"]!.contains("svg")
                      ? SvgIconImage(
                          flag: e.value["flag"],
                          languageKey: e.key,
                        )
                      : Image.asset(e.value["flag"] ?? "",
                          height: 20, width: 40),
                  key: ValueKey(e.key),
                  onTap: () {
                    languageController.languageCode = e.key;
                  },
                ))
            .toList());
  }
}

class SvgIconImage extends StatelessWidget {
  const SvgIconImage({Key? key, required this.flag, required this.languageKey})
      : super(key: key);

  final String? flag;
  final String? languageKey;
  @override
  Widget build(BuildContext context) {
    var languageController = Get.find<LanguageController>();
    return Stack(alignment: Alignment.center, children: [
      SvgPicture.asset(flag ?? "", height: 20, width: 40),
      Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            languageController.languageCode = languageKey ?? "";
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: 45,
            height: 45,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
          ),
        ),
      )
    ]);
  }
}

class AssetForm extends StatelessWidget {
  const AssetForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset('assets/High_five_pana.svg',
        width: 200, height: 200);
  }
}

class LoginStates extends StatelessWidget {
  const LoginStates(
      {Key? key, required this.loginCtrl, required this.languageCtrl})
      : super(key: key);

  final LoginController loginCtrl;
  final LanguageController languageCtrl;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (controller) {
      return controller.isLogged.value == true
          ? Center(
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.transparent,
                      child: SvgPicture.asset(
                        'assets/Wishes-cuate.svg',
                        height: 300,
                        width: 300,
                      ),
                    ),
                    Text(
                      TranslationHelper().getTranslated("welcome") +
                          " " +
                          controller.user.value.firstName.toString(),
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      onPressed: () {
                        Navigator.of(context).pushNamed('homeScreen');
                      },
                    ),
                  ]),
            )
          : Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(TranslationHelper().getTranslated("appName"),
                      style: GoogleFonts.montserrat().copyWith(
                        fontSize: 40,
                        color: ColorsApp.primary,
                        fontWeight: FontWeight.bold,
                      )),
                  const AssetForm(),
                  LoginForm(loginCtrl: loginCtrl),
                ],
              ),
            );
    });
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
    required this.loginCtrl,
  }) : super(key: key);

  final LoginController loginCtrl;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (controller) {
      return controller.isWait.value == true
          ? CircularProgressIndicator(
              color: ColorsApp.primary,
            )
          : Form(
              child: Column(children: [
              Obx(() => TextFormField(
                  autocorrect: false,
                  controller: loginCtrl.email.value,
                  decoration: FormFieldResourses()
                      .formfield('email', 'enterEmail', Icons.email))),
              Obx(() => TextFormField(
                    autocorrect: false,
                    controller: loginCtrl.password.value,
                    obscureText: true,
                    decoration: FormFieldResourses()
                        .formfield("password", "enterPassword", Icons.lock),
                  )),
              const SizedBox(height: 20),
              Obx(() => ElevatedButton(
                    style: AppButtonsResourses().primaryButton,
                    child: Text(TranslationHelper().getTranslated("login"),
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: GoogleFonts.montserrat().fontFamily,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5)),
                    onPressed: () {
                      controller.login(context);
                    },
                  )),
              Obx(() => TextButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed('newAccount'),
                    child: Text(
                      TranslationHelper().getTranslated("newAccount"),
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        color: ColorsApp.primary,
                      ),
                    ),
                  )),
            ]));
    });
  }
}
