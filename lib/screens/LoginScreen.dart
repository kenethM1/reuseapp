import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:reuseapp/models/User.dart';
import 'package:reuseapp/utils/restClient.dart';

import '../controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginCtrl = Get.put<LoginController>(LoginController());

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/High_five_pana.svg',
              width: 200,
              height: 200,
              placeholderBuilder: (BuildContext context) =>
                  CircularProgressIndicator(),
            ),
            Form(
                onChanged: loginCtrl.formChanged,
                child: Column(children: [
                  Obx(() => TextFormField(
                        autocorrect: false,
                        controller: loginCtrl.email.value,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          prefixIcon: Icon(Icons.email),
                        ),
                      )),
                  Obx(() => TextFormField(
                        autocorrect: false,
                        controller: loginCtrl.password.value,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          hintText: 'Enter your password',
                        ),
                      )),
                  Obx(() => ElevatedButton(
                        child: Text(
                            loginCtrl.isLogged.isTrue ? 'Logged' : 'Login'),
                        onPressed: () {
                          loginCtrl.login();
                        },
                      ))
                ])),
          ],
        ),
      ),
    );
  }
}
