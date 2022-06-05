import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reuseapp/Widgets/Carrousel_Widget.dart';
import 'package:reuseapp/utils/resourses/AppFontsResourses.dart';
import 'package:reuseapp/utils/resourses/appButtonsResourses.dart';

import '../controllers/shopping_cart_controller.dart';
import '../models/Product.dart';
import '../utils/TranslationsHelper.dart';

class ShoppingCartModalWidget extends StatelessWidget {
  const ShoppingCartModalWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var shoppingCart = Get.find<ShoppingCartController>();
    var phoneScreen = MediaQuery.of(context).size;
    var translator = TranslationHelper();
    return Container(
      height: phoneScreen.height * 0.6,
      width: phoneScreen.width * 0.8,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
        Radius.circular(10),
      )),
      child: Obx(() => shoppingCart.addedProducts.isEmpty
          ? Column(
              children: [
                Image.asset('assets/Empty.gif',
                    height: phoneScreen.height * 0.3),
                Text(translator.getTranslated("emptyCart"),
                    style: AppFontsResourses().titles,
                    textAlign: TextAlign.center),
                SizedBox(
                  height: 10,
                ),
                Text(translator.getTranslated("emptyCartDesc"),
                    textAlign: TextAlign.center,
                    style: AppFontsResourses().secondaryText.copyWith(
                        fontStyle: FontStyle.italic,
                        fontSize: 16,
                        color: Colors.grey)),
              ],
            )
          : Container(
              width: phoneScreen.width * 0.7,
              height: phoneScreen.height * 0.6,
              child: Column(
                children: [
                  Container(
                    height: phoneScreen.height * 0.51,
                    child: ListView.custom(
                      itemExtent: phoneScreen.height * 0.34,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      semanticChildCount: shoppingCart.addedProducts.length,
                      physics: const BouncingScrollPhysics(),
                      controller: ScrollController(),
                      dragStartBehavior: DragStartBehavior.down,
                      childrenDelegate:
                          SliverChildBuilderDelegate((context, index) {
                        var product = shoppingCart.addedProducts[index];
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(180),
                                    child: Image.network(
                                      product.sellerAccount!.profilePicture ??
                                          "",
                                      height: 50,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(Icons.error),
                                    )),
                                Flexible(
                                  child: Text(
                                    product.sellerAccount!.firstName! +
                                        " " +
                                        product.sellerAccount!.lastName!,
                                    style: AppFontsResourses().nameStyle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                            Container(
                              width: phoneScreen.width * 0.5,
                              height: phoneScreen.height * 0.15,
                              child: CarouselSlider(
                                items: product.images
                                    ?.map((e) =>
                                        Image.network(e.url!, height: 100))
                                    .toList(),
                                options: CarouselOptions(
                                    padEnds: false,
                                    height: 150,
                                    enlargeCenterPage: false,
                                    viewportFraction: 0.5,
                                    pauseAutoPlayInFiniteScroll: true,
                                    autoPlay: true,
                                    disableCenter: false,
                                    enlargeStrategy:
                                        CenterPageEnlargeStrategy.scale),
                              ),
                            ),
                            Container(
                              width: phoneScreen.width * 0.66,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    product.title!,
                                    style: AppFontsResourses().nameStyle,
                                    overflow: TextOverflow.clip,
                                  ),
                                  Text(
                                    "L" + product.price!.toString(),
                                    style: AppFontsResourses().nameStyle,
                                    overflow: TextOverflow.clip,
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton.icon(
                              style: AppButtonsResourses().secundarybutton,
                              onPressed: () =>
                                  shoppingCart.RemoveProductFromList(product),
                              icon: const Icon(
                                Icons.remove_circle_outline_rounded,
                                color: Colors.white,
                              ),
                              label: Text(
                                translator.getTranslated("remove"),
                                style: AppFontsResourses()
                                    .nameStyle
                                    .copyWith(color: Colors.white),
                              ),
                            )
                          ],
                        );
                      }, childCount: shoppingCart.addedProducts.length),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        translator.getTranslated("total"),
                        style: AppFontsResourses().nameStyle.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                      ),
                      Text(
                        'L ${shoppingCart.addedProducts.fold<double>(0, (previousValue, element) => previousValue + double.parse(element.price.toString())).toString()}',
                        style: AppFontsResourses().nameStyle.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushNamed('checkout');
                      },
                      style: AppButtonsResourses().secundarybutton,
                      icon: Icon(Icons.shopping_cart_checkout_outlined),
                      label: Text(translator.getTranslated("checkout"),
                          style: AppFontsResourses()
                              .nameStyle
                              .copyWith(color: Colors.white)))
                ],
              ),
            )),
    );
  }
}
