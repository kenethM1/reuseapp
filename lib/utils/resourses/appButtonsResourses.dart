import 'package:flutter/material.dart';
import 'package:reuseapp/utils/colors.dart';

class AppButtonsResourses {
  final primaryButton = ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.symmetric(horizontal: 40, vertical: 10)),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    )),
    backgroundColor: MaterialStateProperty.all<Color>(ColorsApp.secondary),
  );
}
