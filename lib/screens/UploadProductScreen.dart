import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:reuseapp/Widgets/Carrousel_Widget.dart';
import 'package:reuseapp/Widgets/UploadImage_Carrousel.dart';
import 'package:reuseapp/models/Brand.dart';
import 'package:reuseapp/models/Size.dart';
import 'package:reuseapp/utils/colors.dart';
import 'package:reuseapp/utils/resourses/AppFontsResourses.dart';
import 'package:reuseapp/utils/resourses/FormFieldResourses.dart';

import '../controllers/categories_controller.dart';
import '../controllers/uploadImageController.dart';
import '../models/Category.dart';
import '../utils/TranslationsHelper.dart';
import '../utils/resourses/appButtonsResourses.dart';

class UploadProductScreen extends StatelessWidget {
  const UploadProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneScreen = MediaQuery.of(context).size;
    var uploadImagesController =
        Get.put<UploadImageController>(UploadImageController());

    CategoriesController categoriesController = Get.find();
    var translate = TranslationHelper();
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: phoneScreen.width,
                    minHeight: phoneScreen.height + 90,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [ColorsApp.primary, ColorsApp.primary],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: uploadImagesController.isLoading.isFalse
                          ? Container(
                              height: phoneScreen.height * 0.8,
                              width: phoneScreen.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: Column(children: [
                                UploadImage_Carrousel(),
                                Form(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Obx(() => SizedBox(
                                            height: phoneScreen.height * 0.1,
                                            width: phoneScreen.width,
                                            child: TextFormField(
                                                controller:
                                                    uploadImagesController
                                                        .productName.value,
                                                decoration: FormFieldResourses()
                                                    .formfield(
                                                        'product_name',
                                                        "enterProductName",
                                                        Icons.text_fields)),
                                          )),
                                      Obx(() => SizedBox(
                                            height: phoneScreen.height * 0.1,
                                            width: phoneScreen.width,
                                            child: TextFormField(
                                                controller:
                                                    uploadImagesController
                                                        .productDescription
                                                        .value,
                                                decoration: FormFieldResourses()
                                                    .formfield(
                                                        'product_description',
                                                        "enterProductDescription",
                                                        Icons.text_fields)),
                                          )),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Obx(() => CategoriesDropdown(
                                                  phoneScreen: phoneScreen,
                                                  translate: translate,
                                                  snapshot: categoriesController
                                                      .categories.value,
                                                )),
                                            Obx(() => SizesDropdown(
                                                  phoneScreen: phoneScreen,
                                                  translate: translate,
                                                  snapshot:
                                                      uploadImagesController
                                                          .sizes.value,
                                                )),
                                          ]),
                                      Obx(() => uploadImagesController
                                              .brands.value.isNotEmpty
                                          ? BrandDropdown(
                                              phoneScreen: phoneScreen,
                                              translate: translate,
                                              snapshot: uploadImagesController
                                                  .brands.value,
                                            )
                                          : const CircularProgressIndicator()),
                                      Obx(() => SizedBox(
                                            height: phoneScreen.height * 0.1,
                                            width: phoneScreen.width,
                                            child: TextFormField(
                                                onChanged: (value) =>
                                                    uploadImagesController
                                                            .price.value =
                                                        int.parse(value),
                                                keyboardType:
                                                    TextInputType.number,
                                                keyboardAppearance:
                                                    Brightness.dark,
                                                decoration: FormFieldResourses()
                                                    .formfield(
                                                        'product_price',
                                                        "enterProductPrice",
                                                        Icons.text_fields)),
                                          )),
                                      Container(
                                        width: phoneScreen.width * 0.6,
                                        height: phoneScreen.height * 0.08,
                                        margin: EdgeInsets.all(20),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            uploadImagesController.addProduct(
                                                categoriesController
                                                    .selectedCategory.value.id,
                                                context);
                                          },
                                          style: AppButtonsResourses()
                                              .primaryButton,
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.add_circle_outline),
                                                SizedBox(width: 5),
                                                Text(translate.getTranslated(
                                                    'addProduct')),
                                              ]),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ]),
                            )
                          : Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ))));
  }
}

class CategoriesDropdown extends StatelessWidget {
  const CategoriesDropdown(
      {Key? key,
      required this.phoneScreen,
      required this.translate,
      required this.snapshot})
      : super(key: key);

  final Size phoneScreen;
  final TranslationHelper translate;
  final List<Category> snapshot;

  @override
  Widget build(BuildContext context) {
    var uploadImageController = Get.find<UploadImageController>();
    return SizedBox(
        width: phoneScreen.width * 0.5,
        height: phoneScreen.height * 0.1,
        child: Obx(() => uploadImageController.sizes.isNotEmpty
            ? DropdownButton<Category>(
                borderRadius: BorderRadius.circular(20),
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: ColorsApp.primary,
                ),
                iconSize: 50,
                underline: Container(
                  height: 2,
                  color: ColorsApp.primary,
                ),
                value: uploadImageController.selectedCategory.value,
                alignment: Alignment.center,
                hint: Text(translate.getTranslated('selectCategory'),
                    style: AppFontsResourses().description),
                items: snapshot.isNotEmpty
                    ? snapshot
                        .toSet()
                        .map((e) => DropdownMenuItem<Category>(
                              value: e,
                              child: Text(e.title ?? "",
                                  style: AppFontsResourses()
                                      .secondaryText
                                      .copyWith(color: Colors.black)),
                            ))
                        .toList()
                    : [
                        DropdownMenuItem<Category>(
                            value: Category(id: 0, title: 'Select Category'),
                            child: Text('Select Category'))
                      ],
                onChanged: (category) {
                  uploadImageController.selectCategory(category!);
                  uploadImageController.update();
                },
              )
            : const CircularProgressIndicator()));
  }
}

class SizesDropdown extends StatelessWidget {
  const SizesDropdown(
      {Key? key,
      required this.phoneScreen,
      required this.translate,
      required this.snapshot})
      : super(key: key);

  final Size phoneScreen;
  final TranslationHelper translate;
  final List<SizeCloth> snapshot;

  @override
  Widget build(BuildContext context) {
    var uploadImagesController = Get.find<UploadImageController>();
    return Obx(() => Container(
        width: phoneScreen.width * 0.35,
        height: phoneScreen.height * 0.1,
        child: uploadImagesController.sizes.isNotEmpty
            ? DropdownButton(
                borderRadius: BorderRadius.circular(20),
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: ColorsApp.primary,
                ),
                iconSize: 50,
                underline: Container(
                  height: 2,
                  color: ColorsApp.primary,
                ),
                value: uploadImagesController.selectedSize.value,
                alignment: Alignment.center,
                hint: Text(translate.getTranslated('selectSize'),
                    style: AppFontsResourses().description),
                items: snapshot.isNotEmpty
                    ? snapshot
                        .toSet()
                        .map((e) => DropdownMenuItem<SizeCloth>(
                              value: e,
                              child: Text(e.size,
                                  style: AppFontsResourses()
                                      .secondaryText
                                      .copyWith(color: Colors.black)),
                            ))
                        .toList()
                    : [
                        DropdownMenuItem<SizeCloth>(
                            value: SizeCloth(sizeId: 0, size: 'Select Size'),
                            child: Text('Select Size'))
                      ],
                onChanged: (SizeCloth? sizeCloth) {
                  uploadImagesController.setSelectedSize = sizeCloth;
                  uploadImagesController.update();
                },
              )
            : const CircularProgressIndicator()));
  }
}

class BrandDropdown extends StatelessWidget {
  const BrandDropdown(
      {Key? key,
      required this.phoneScreen,
      required this.translate,
      required this.snapshot})
      : super(key: key);

  final Size phoneScreen;
  final TranslationHelper translate;
  final List<Brand> snapshot;

  @override
  Widget build(BuildContext context) {
    var uploadImagesController = Get.find<UploadImageController>();
    return Container(
        width: phoneScreen.width * 0.8,
        height: phoneScreen.height * 0.1,
        child: Obx(() => uploadImagesController.brands.isNotEmpty
            ? DropdownButton(
                borderRadius: BorderRadius.circular(20),
                isExpanded: true,
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: ColorsApp.primary,
                ),
                iconSize: 50,
                underline: Container(
                  height: 2,
                  color: ColorsApp.primary,
                ),
                value: uploadImagesController.selectedBrand.value,
                alignment: Alignment.center,
                hint: Text(translate.getTranslated('selectedBrand'),
                    style: AppFontsResourses().description),
                items: snapshot.isNotEmpty
                    ? snapshot
                        .toSet()
                        .map((e) => DropdownMenuItem<Brand>(
                              value: e,
                              child: Text(e.name ?? "",
                                  style: AppFontsResourses()
                                      .secondaryText
                                      .copyWith(color: Colors.black)),
                            ))
                        .toList()
                    : [
                        DropdownMenuItem<Brand>(
                            value: Brand(id: 0, name: 'Select Brand'),
                            child: Text('Select Brand'))
                      ],
                onChanged: (Brand? brand) {
                  uploadImagesController.setSelectedBrand = brand;
                  uploadImagesController.update();
                })
            : const CircularProgressIndicator()));
  }
}
