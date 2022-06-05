import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:reuseapp/controllers/language_controller.dart';
import 'package:reuseapp/models/City.dart';
import 'package:reuseapp/utils/colors.dart';
import 'package:reuseapp/utils/resourses/AppFontsResourses.dart';
import 'package:reuseapp/utils/resourses/FormFieldResourses.dart';
import 'package:reuseapp/utils/resourses/appButtonsResourses.dart';
import 'package:reuseapp/utils/translationsHelper.dart';

import '../controllers/seller_form_controller.dart';

class SellerForm extends StatelessWidget {
  const SellerForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneScreen = MediaQuery.of(context).size;
    var sellerController =
        Get.put<SellerFormController>(SellerFormController());
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
                      translator.getTranslated('seller_form_title'),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.all(20),
                      child: TypeAheadField<City>(
                        textFieldConfiguration: TextFieldConfiguration(
                          onTap: () =>
                              sellerController.cityController.value.text = "",
                          controller: sellerController.cityController.value,
                          decoration: FormFieldResourses()
                              .formfield("city", "city", Icons.location_city),
                        ),
                        suggestionsCallback: ((pattern) =>
                            sellerController.getAvailableCity(pattern)),
                        itemBuilder: (context, City suggestion) => ListTile(
                          trailing: Icon(Icons.location_city),
                          title: Text(suggestion.name),
                        ),
                        onSuggestionSelected: (suggestion) {
                          sellerController.cityController.value.text =
                              suggestion.name.toString();
                        },
                      )),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      onChanged: (value) =>
                          sellerController.address.value = value,
                      decoration: FormFieldResourses()
                          .formfield("address", "address", Icons.location_on),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      onChanged: (value) =>
                          sellerController.phoneNumber.value = value,
                      decoration: FormFieldResourses()
                          .formfield("phone", "phone", Icons.phone),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      onChanged: (value) =>
                          sellerController.dniNumber.value = value,
                      decoration: FormFieldResourses()
                          .formfield("dni", "dni", Icons.person),
                    ),
                  ),
                  Obx(() => ImageSelector(
                        translator: translator,
                        label: translator.getTranslated("getDNIFrontImage"),
                        propName: "getDNIFrontImage",
                      )),
                  Obx(() => ImageSelector(
                        translator: translator,
                        label: translator.getTranslated("getDNIBackImage"),
                        propName: "getDNIBackImage",
                      )),
                  Obx(() => CheckboxListTile(
                        title: Text(translator.getTranslated('accept_terms'),
                            style: AppFontsResourses()
                                .secondaryText
                                .copyWith(fontSize: 13)),
                        value: sellerController.acceptTerms.value,
                        selectedTileColor: ColorsApp.secondary,
                        activeColor: ColorsApp.secondary,
                        onChanged: (value) {
                          sellerController.acceptTerms.value = value ?? false;
                        },
                      )),
                  Obx(() => CheckboxListTile(
                        title: Text(
                            translator.getTranslated('accept_terms_devolution'),
                            style: AppFontsResourses()
                                .secondaryText
                                .copyWith(fontSize: 13)),
                        value: sellerController.acceptDevolutionterms.value,
                        selectedTileColor: ColorsApp.secondary,
                        activeColor: ColorsApp.secondary,
                        onChanged: (value) {
                          sellerController.acceptDevolutionterms.value =
                              value ?? false;
                        },
                      )),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton.icon(
                        onPressed: () {
                          sellerController.uploadSellerForm(context);
                        },
                        style: AppButtonsResourses().secundarybutton,
                        icon: Icon(Icons.upload),
                        label: Text(translator.getTranslated('upload_data'))),
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

class ImageSelector extends StatelessWidget {
  const ImageSelector(
      {Key? key,
      required this.translator,
      required this.label,
      required this.propName})
      : super(key: key);

  final TranslationHelper translator;
  final String label;
  final String propName;
  @override
  Widget build(BuildContext context) {
    var phoneScreen = MediaQuery.of(context).size;
    var sellerController = Get.find<SellerFormController>();
    return Container(
        width: phoneScreen.width * 0.7,
        height: phoneScreen.height * 0.30,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(translator.getTranslated(label),
                style: AppFontsResourses().secondaryText.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    )),
          ),
          Container(
            width: phoneScreen.width * 0.7,
            height: phoneScreen.height * 0.25,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Obx(() => FutureBuilder(
                      future: sellerController.GetImage(propName),
                      builder: (context, AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.data != null) {
                          return Container(
                              width: phoneScreen.width * 0.7,
                              height: phoneScreen.height * 0.25,
                              child: snapshot.data);
                        }
                        return Container();
                      },
                    )),
                Container(
                  alignment: Alignment.center,
                  child: Center(
                      child: IconButton(
                    onPressed: () async {
                      sellerController.pickImage(propName, label);
                    },
                    icon: Icon(Icons.add_photo_alternate),
                  )),
                ),
              ],
            ),
          ),
        ]));
  }
}
