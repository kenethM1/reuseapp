import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reuseapp/firebase_options.dart';
import 'package:reuseapp/screens/CheckOutScreen.dart';
import 'package:reuseapp/screens/HomeScreen.dart';
import 'package:reuseapp/screens/LoginScreen.dart';
import 'package:reuseapp/screens/RegisterScreen.dart';
import 'package:reuseapp/screens/SellerForm.dart';
import 'package:reuseapp/screens/UploadProductScreen.dart';
import 'package:reuseapp/screens/VerifyAccountScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        'addProduct': (context) => UploadProductScreen(),
        'sellerForm': (context) => SellerForm(),
        'checkout': (context) => CheckOutScreen(),
      },
    );
  }
}
