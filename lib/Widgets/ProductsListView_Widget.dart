import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reuseapp/utils/colors.dart';
import 'package:reuseapp/utils/resourses/AppFontsResourses.dart';

import '../controllers/products_controller.dart';
import '../models/Product.dart';
import 'ProductItem.dart';

class ProductsListView extends StatelessWidget {
  const ProductsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var productsController = Get.find<ProductsController>();
    var phoneScreen = MediaQuery.of(context).size;
    return Container(
        child: Obx(() => ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: productsController.products.length,
              itemBuilder: (context, index) {
                var product = productsController.products[index];
                return ProductItem(product: product);
              },
            )));
  }
}
