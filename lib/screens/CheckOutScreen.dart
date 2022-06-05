import 'package:flutter/material.dart';
import 'package:reuseapp/screens/LoginScreen.dart';
import 'package:reuseapp/utils/resourses/AppFontsResourses.dart';
import 'package:reuseapp/utils/resourses/FormFieldResourses.dart';
import 'package:reuseapp/utils/resourses/card_available.dart';

import '../utils/TranslationsHelper.dart';
import '../utils/colors.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneScreen = MediaQuery.of(context).size;
    var translator = TranslationHelper();
    return SafeArea(
      child: Material(
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ColorsApp.primary,
          ),
          child: Container(
            width: phoneScreen.width * 0.8,
            height: phoneScreen.height * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      translator.getTranslated('check_out_title'),
                      style: AppFontsResourses().titles,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      translator.getTranslated('check_out_description'),
                      style: AppFontsResourses().description.copyWith(
                            color: Colors.black,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: phoneScreen.width * 0.8,
                    height: phoneScreen.height * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          child: TextField(
                              maxLength: 12,
                              decoration: FormFieldResourses().formfield(
                                  'card_information',
                                  'enter_card_information',
                                  Icons.credit_card)),
                        ),
                        Row(
                            children: CardsAvailables()
                                .types
                                .map((e) => Container(
                                      width: 25,
                                      height: 25,
                                      child: InkWell(
                                        splashColor: ColorsApp.primary,
                                        focusColor: ColorsApp.primary,
                                        child: e["flag"]!.contains("svg")
                                            ? SvgIconImage(
                                                flag: e["flag"],
                                                languageKey: e['name'],
                                              )
                                            : Image.asset(e["flag"] ?? "",
                                                height: 20, width: 40),
                                        key: ValueKey(e["name"]),
                                        onTap: () {},
                                      ),
                                    ))
                                .toList())
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
