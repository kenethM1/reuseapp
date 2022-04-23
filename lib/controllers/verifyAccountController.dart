import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reuseapp/utils/translationsHelper.dart';
import 'package:http/http.dart' as http;
import 'package:reuseapp/utils/restClient.dart';

class VerifyAccountController extends GetxController {
  var codeController = TextEditingController();

  String? validateCode(String value) {
    if (value.isEmpty) {
      return 'Code is required';
    }
    return null;
  }

  set codeValue(String value) {
    codeController.text = value;
    update();
  }

  Future<void> verifyAccount(BuildContext context) async {
    if (validateCode(codeController.text) == null) {
      var request = MaterializeRequest(codeController.text);
      var hearders = {
        'Content-Type': 'application/json',
      };
      http.Response response = await restClient(
              body: request,
              method: 'POST',
              url: '/Accounts/verify-email',
              headers: hearders)
          .execute();
      if (response.statusCode == 200) {
        Navigator.of(context).pushNamed('homeScreen');
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
                  )
                ],
              );
            });
      }
    }
  }
}

Map<String, dynamic> MaterializeRequest(String text) {
  return {
    'token': text,
  };
}
