import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reuseapp/models/Category.dart';
import 'package:reuseapp/utils/colors.dart';
import 'package:reuseapp/utils/resourses/AppFontsResourses.dart';

import '../controllers/categories_controller.dart';

class CarrouselWidget extends StatelessWidget {
  const CarrouselWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var categoriesController =
        Get.put<CategoriesController>(CategoriesController());
    var phoneSize = MediaQuery.of(context).size;

    return Container(
        child: GetBuilder<CategoriesController>(builder: ((controller) {
      return FutureBuilder<List<Category>>(
        future: controller.getCategories(),
        builder: (context, snapshot) => snapshot.hasData
            ? CarouselSlider(
                options: CarouselOptions(
                  height: phoneSize.height * 0.25,
                  disableCenter: true,
                  viewportFraction: 0.25,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    controller.selectCategory(snapshot.data![index]);
                  },
                ),
                items: snapshot.data!.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Column(
                        children: [
                          Container(
                            width: phoneSize.width * 0.15,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(300),
                              child: Image.network(
                                i.imageUrl ?? '',
                                fit: BoxFit.fill,
                                loadingBuilder: (context, widget, imageChunk) =>
                                    (imageChunk?.expectedTotalBytes ?? 0) /
                                                (imageChunk
                                                        ?.cumulativeBytesLoaded ??
                                                    0) >
                                            0.5
                                        ? Container(
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                            Color>(
                                                        ColorsApp.secondary),
                                              ),
                                            ),
                                          )
                                        : widget,
                              ),
                            ),
                          ),
                          Text(i.title ?? '',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.black,
                              ))
                        ],
                      );
                    },
                  );
                }).toList(),
              )
            : CircularProgressIndicator(
                color: ColorsApp.primary,
              ),
      );
    })));
  }
}
