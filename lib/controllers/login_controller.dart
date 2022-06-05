import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:reuseapp/utils/restClient.dart';

import '../models/User.dart';

class LoginController extends GetxController {
  var email = TextEditingController().obs;
  var password = TextEditingController().obs;
  var scrollController = ScrollController().obs;
  var isLogged = false.obs;
  var isWait = false.obs;
  var errorMessage = "".obs;
  var user = User().obs;
  var drawerIsOpen = false.obs;

  get getUserProfilePicture => user.value.profilePicture ?? "";

  get userIsSeller => user.value.hasApprovedSellerForm ?? false;

  String get getUserName => user.value.firstName! + " " + user.value.lastName!;

  Future<void> login(BuildContext context) async {
    String uri = "/Accounts/authenticate";
    Map<String, String> headers = {
      "Content-type": "application/json",
    };

    _updateValue(isLogged, value: false);
    _updateValue(isWait, value: true);

    Map<String, String> body = {
      'email': email.value.text,
      'password': password.value.text,
    };
    http.Response response = new http.Response("", 200);
    try {
      response = await restClient(
              url: uri, method: 'POST', headers: headers, body: body)
          .execute();
    } catch (e) {
      _updateValue(isWait, value: false);
      _updateValue(isLogged, value: false);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text("Error")));
    }

    if (response.statusCode == 200) {
      user.value = User.fromJson(json.decode(response.body));
      isLogged.value = true;
      _updateValue(isWait, value: false);
      _updateValue(isLogged, value: true);
      debugPrint('user: ${user.toJson()}');
    } else {
      _updateValue(isWait, value: false);
      _updateValue(isLogged, value: false);
      errorMessage.value = response.body;
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text("Error"),
                content: Text(errorMessage.value),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Ok"),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              ));
    }
  }

  void _updateValue(RxBool isWait, {bool? value}) {
    isWait.value = value ?? isWait.value;
    update();
  }

  void loggedOut() {
    isLogged.value = false;
    update();
  }
}
