import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:reuseapp/models/User.dart';
import 'package:reuseapp/utils/restClient.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          children: [
            FutureBuilder(
              future: loginValidation(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Text("Sign in success");
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return ElevatedButton(
                  onPressed: () {
                    loginValidation();
                  },
                  child: const Text('Login'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> loginValidation() async {
    String uri = "/Accounts/authenticate";
    Map<String, String> headers = {
      "Content-type": "application/json",
    };

    Map<String, String> body = {
      'email': 'kenethperez56@gmail.com',
      'password': 'CopanRuinas2022',
    };

    Response response =
        await restClient(url: uri, method: 'POST', headers: headers, body: body)
            .execute();

    if (response.statusCode == 200) {
      var user = User.fromJson(json.decode(response.body));
      return true;
    }
    return false;
  }
}
