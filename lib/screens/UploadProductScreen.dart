import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:reuseapp/Widgets/Carrousel_Widget.dart';
import 'package:reuseapp/Widgets/UploadImage_Carrousel.dart';
import 'package:reuseapp/utils/colors.dart';
import 'package:reuseapp/utils/resourses/FormFieldResourses.dart';

import '../controllers/uploadImageController.dart';
import '../utils/TranslationsHelper.dart';

class UploadProductScreen extends StatelessWidget {
  const UploadProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneScreen = MediaQuery.of(context).size;
    var uploadImagesController =
        Get.put<UploadImageController>(UploadImageController());
    var translate = TranslationHelper();
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              UploadImage_Carrousel(
                  uploadImagesController: uploadImagesController),
              Form(
                  child: Column(
                children: [
                  TextFormField(
                      decoration: FormFieldResourses()
                          .formfield('product_Name', "enterProductName", null)),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
