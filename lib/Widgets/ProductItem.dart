import 'package:animate_icons/animate_icons.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reuseapp/controllers/shopping_cart_controller.dart';
import 'package:reuseapp/utils/colors.dart';
import 'package:reuseapp/utils/resourses/AppFontsResourses.dart';
import 'package:reuseapp/utils/resourses/appButtonsResourses.dart';
import 'package:reuseapp/utils/translationsHelper.dart';

import '../models/Product.dart';
import 'Avatar_Widget.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(
      {Key? key, required this.product, required this.shoppingCart})
      : super(key: key);

  final Product product;
  final ShoppingCartController shoppingCart;

  bool onEndIconPress(BuildContext context, Product product) {
    shoppingCart.RemoveProductFromList(product);
    return true;
  }

  bool onStartIconPress(BuildContext context, Product product) {
    shoppingCart.AddProductToList(product);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var phoneScreen = MediaQuery.of(context).size;
    final translator = TranslationHelper();
    AnimateIconController controller = AnimateIconController();
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 15,
                spreadRadius: 3,
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AvatarWidget(
                        profilePicture:
                            product.sellerAccount!.profilePicture ?? "",
                        size: 15,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        product.sellerAccount!.firstName! +
                            " " +
                            product.sellerAccount!.lastName!,
                        style: AppFontsResourses()
                            .secondaryText
                            .copyWith(color: Colors.black, fontSize: 18),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ],
                ),
              ),
              CarouselSlider(
                items: product.images
                    ?.map((e) => Image.network(e.url ?? ""))
                    .toList(),
                options: CarouselOptions(
                    height: 200,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 5),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    pauseAutoPlayOnTouch: true),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      product.title ?? "",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Column(
                    children: [
                      Text(product.price!.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          )),
                      Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ColorsApp.primary,
                        ),
                        child: Obx(
                          () => AnimateIcons(
                              duration: const Duration(milliseconds: 500),
                              startIconColor: Colors.white,
                              clockwise: false,
                              endIconColor: Colors.white,
                              startTooltip:
                                  translator.getTranslated('add_to_cart'),
                              endTooltip:
                                  translator.getTranslated('remove_from_cart'),
                              startIcon: Icons.shopping_cart_outlined,
                              endIcon: Icons.check,
                              onStartIconPress: () =>
                                  onStartIconPress(context, product),
                              onEndIconPress: () =>
                                  onEndIconPress(context, product),
                              controller: controller),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
