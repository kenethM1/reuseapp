import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:reuseapp/controllers/login_controller.dart';
import 'package:reuseapp/utils/TranslationsHelper.dart';
import 'package:reuseapp/utils/restClient.dart';

import '../models/User.dart';

class RegisterController extends GetxController {
  var email = ''.obs;
  var emailErrorText = ''.obs;
  var password = ''.obs;
  var passwordErrorText = ''.obs;
  var firstName = ''.obs;
  var lastName = ''.obs;
  var acceptTerms = false.obs;
  var canSeePassword = false.obs;

  var loginController = Get.find<LoginController>();
  var validEmailPattern = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();

  set passwordValue(String value) {
    password.value = value;
    if (value.isNotEmpty) {
      passwordErrorText.value = validatePassword(value);
    }
    update();
  }

  set emailControllerValue(String value) {
    emailController.text = value;
    if (value.isNotEmpty) {
      emailErrorText.value = validateEmail(value);
    }
    update();
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      return TranslationHelper().getTranslated('password_required');
    } else if (value.length < 6) {
      return TranslationHelper().getTranslated('password_min_length');
    } else {
      return '';
    }
  }

  String validateEmail(String value) {
    if (value.isEmpty) {
      return TranslationHelper().getTranslated('email_required');
    } else if (!validEmailPattern.hasMatch(value)) {
      return TranslationHelper().getTranslated('email_invalid');
    }
    return "";
  }

  set passwordControllerValue(String value) {
    passwordController.text = value;
    update();
  }

  set firstNameControllerValue(String value) {
    firstNameController.text = value;
    update();
  }

  set lastNameControllerValue(String value) {
    lastNameController.text = value;
    update();
  }

  String validateForm() {
    if (emailController.value.text.isEmpty) {
      return TranslationHelper().getTranslated('email_required');
    } else if (!validEmailPattern.hasMatch(emailController.value.text)) {
      return TranslationHelper().getTranslated('email_invalid');
    } else if (password.value.isEmpty) {
      return TranslationHelper().getTranslated('password_required');
    } else if (password.value.length < 6) {
      return TranslationHelper().getTranslated('password_min_length');
    } else if (firstNameController.text.isEmpty) {
      return TranslationHelper().getTranslated('first_name_required');
    } else if (lastNameController.text.isEmpty) {
      return TranslationHelper().getTranslated('last_name_required');
    } else if (!acceptTerms.isTrue) {
      return TranslationHelper().getTranslated('accept_terms');
    }
    return '';
  }

  Future<void> tryRegister(BuildContext context) async {
    if (validateForm() == '') {
      var request = RegisterRequest(
          emailController.value.text,
          password.value,
          firstNameController.value.text,
          lastNameController.value.text,
          acceptTerms.value);
      http.Response response = await restClient(
        body: request,
        method: 'POST',
        url: '/Accounts/register',
        headers: {
          'Content-Type': 'application/json',
        },
      ).execute();
      if (response.statusCode == 200) {
        loginController.user.value = User.fromJson(json.decode(response.body));
        Navigator.of(context).pushNamed('verifyCode');
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(TranslationHelper().getTranslated('error')),
                content: Text(response.body),
                actions: <Widget>[
                  ElevatedButton(
                    child: Text(TranslationHelper().getTranslated('ok')),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      }
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(TranslationHelper().getTranslated('error')),
              content: Text(validateForm()),
              actions: <Widget>[
                ElevatedButton(
                  child: Text(TranslationHelper().getTranslated('ok')),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }
  }

  void clear() {
    emailController.clear();
    passwordController.clear();
    firstNameController.clear();
    lastNameController.clear();
  }
}

Map<String, dynamic> RegisterRequest(String email, String password,
    String firstName, String lastName, bool acceptTerms) {
  return {
    'title': 'user',
    'email': email,
    'password': password,
    'confirmPassword': password,
    'firstName': firstName,
    'lastName': lastName,
    'acceptTerms': acceptTerms
  };
}
