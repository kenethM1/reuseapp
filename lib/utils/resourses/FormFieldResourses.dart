import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../TranslationsHelper.dart';
import '../colors.dart';

class FormFieldResourses {
  InputDecoration formfield(String labelText, String hintText, IconData? icon) {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorsApp.primary,
          width: 2,
        ),
      ),
      counterStyle: TextStyle(color: ColorsApp.primary),
      labelText: TranslationHelper().getTranslated(labelText),
      labelStyle: GoogleFonts.montserrat(
        fontSize: 20,
        color: ColorsApp.primary,
      ),
      prefixIcon: Icon(
        icon,
        color: ColorsApp.primary,
      ),
      hintText: TranslationHelper().getTranslated(hintText),
    );
  }
}
