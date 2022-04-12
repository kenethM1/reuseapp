import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:reuseapp/utils/restClient.dart';

import '../models/User.dart';

class LoginController extends GetxController {
  var email = TextEditingController().obs;
  var password = TextEditingController().obs;
  var isLogged = false.obs;

  void formChanged() {
    debugPrint('form changed');
    debugPrint('email: ${email.value.text}');
    debugPrint('password: ${password.value.text}');
  }

  Future<void> login() async {
    String uri = "/Accounts/authenticate";
    Map<String, String> headers = {
      "Content-type": "application/json",
    };

    Map<String, String> body = {
      'email': email.value.text,
      'password': password.value.text,
    };

    http.Response response =
        await restClient(url: uri, method: 'POST', headers: headers, body: body)
            .execute();

    if (response.statusCode == 200) {
      var user = User.fromJson(json.decode(response.body));
      isLogged.value = true;
      debugPrint('user: ${user.toJson()}');
    }
  }
}
