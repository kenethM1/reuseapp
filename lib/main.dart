import 'package:flutter/material.dart';
import 'package:reuseapp/screens/HomeScreen.dart';
import 'package:reuseapp/screens/LoginScreen.dart';
import 'package:reuseapp/screens/RegisterScreen.dart';
import 'package:reuseapp/screens/VerifyAccountScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
      routes: {
        'login': (context) => LoginScreen(),
        'newAccount': (context) => RegisterAccount(),
        'verifyCode': (context) => VerifyAccountScreen(),
        'homeScreen': (context) => HomeScreen(),
      },
    );
  }
}
