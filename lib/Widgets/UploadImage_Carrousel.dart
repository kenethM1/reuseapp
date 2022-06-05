import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:reuseapp/controllers/uploadImageController.dart';
import 'package:reuseapp/utils/colors.dart';

import '../utils/TranslationsHelper.dart';

class UploadImage_Carrousel extends StatelessWidget {
  const UploadImage_Carrousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneScreen = MediaQuery.of(context).size;
    var translate = TranslationHelper();
    final UploadImageController uploadImagesController =
        Get.put(UploadImageController());
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
          height: phoneScreen.height * 0.3,
          decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Center(
            child: Stack(fit: StackFit.expand, children: [
              Obx(() => FutureBuilder(
                    future: uploadImagesController.GetImages(),
                    builder: (context, AsyncSnapshot<List<Image>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return CarouselSlider(
                          items: snapshot.data?.map((e) => e).toList() ?? [],
                          options: CarouselOptions(
                              autoPlayCurve: Curves.easeIn,
                              disableCenter: false,
                              enlargeCenterPage: true,
                              autoPlay: true,
                              scrollDirection: Axis.horizontal),
                        );
                      }
                      return Container();
                    },
                  )),
              InkWell(
                onTap: () async {
                  var images = await MultiImagePicker.pickImages(
                      maxImages: 5,
                      selectedAssets: uploadImagesController.images.value,
                      enableCamera: true,
                      materialOptions: MaterialOptions(
                          actionBarTitle: translate.getTranslated('addImages'),
                          allViewTitle: translate.getTranslated('allPhotos'),
                          lightStatusBar: false,
                          startInAllView: true,
                          selectionLimitReachedText:
                              translate.getTranslated("maxImages"),
                          textOnNothingSelected:
                              translate.getTranslated("nothingSelected"),
                          autoCloseOnSelectionLimit: true));
                  for (var image in images) {
                    debugPrint(image.name.toString());
                  }
                  uploadImagesController.images.value = images;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(translate.getTranslated('uploadingImages')),
                    ),
                  );
                },
                child: Obx(
                  (() => Opacity(
                        opacity: uploadImagesController.anyImage() ? 0.1 : 1,
                        child: Icon(
                          Icons.add_circle,
                          size: 100,
                          color: ColorsApp.secondary,
                        ),
                      )),
                ),
              )
            ]),
          )),
    );
  }
}
