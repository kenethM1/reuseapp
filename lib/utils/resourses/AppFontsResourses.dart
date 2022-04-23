import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reuseapp/utils/colors.dart';

class AppFontsResourses {
  var titles = GoogleFonts.poppins(
    fontSize: 30,
    color: ColorsApp.secondary,
  );

  var secondaryText = GoogleFonts.poppins(
    fontSize: 20,
    color: ColorsApp.secondary,
  );

  final secondaryWhite = GoogleFonts.poppins(
    fontSize: 20,
    color: Colors.white,
  );

  final description = GoogleFonts.poppins(
    fontSize: 15,
    color: ColorsApp.secondary,
  );
}
