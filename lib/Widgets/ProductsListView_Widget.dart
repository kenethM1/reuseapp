import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reuseapp/utils/colors.dart';
import 'package:reuseapp/utils/resourses/AppFontsResourses.dart';

import '../controllers/products_controller.dart';
import '../controllers/shopping_cart_controller.dart';
import '../models/Product.dart';
import '../utils/TranslationsHelper.dart';
import 'ProductItem.dart';

class ProductsListView extends StatelessWidget {
  const ProductsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var productsController = Get.find<ProductsController>();
    var phoneScreen = MediaQuery.of(context).size;
    var shoppingCart = Get.find<ShoppingCartController>();
    var translator = TranslationHelper();
    return Container(
        child: Obx(() => (productsController.filteredProducts.isEmpty &&
                    productsController.isFiltering.isTrue) ||
                productsController.filteredProducts.isEmpty
            ? SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: phoneScreen.height * 0.7,
                  ),
                  child: Container(
                    height: phoneScreen.height * 0.5,
                    child: Column(
                      children: [
                        Image.asset('assets/Empty.gif',
                            height: phoneScreen.height * 0.3),
                        Center(
                          child: Text(
                            translator.getTranslated("emptySearch"),
                            style: AppFontsResourses().nameStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: productsController.isFiltering.isTrue
                    ? productsController.filteredProducts.length
                    : productsController.products.length,
                itemBuilder: (context, index) {
                  var product = productsController.isFiltering.isTrue
                      ? productsController.filteredProducts[index]
                      : productsController.products[index];
                  return ProductItem(
                      product: product, shoppingCart: shoppingCart);
                },
              )));
  }
}
