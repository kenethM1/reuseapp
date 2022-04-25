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
    var productsController = Get.put<ProductsController>(ProductsController());

    return Container(
        child: FutureBuilder<List<Product>>(
      future: productsController.getProducts(),
      builder: ((context, snapshot) => snapshot.hasData
          ? ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: ProductItem(
                    product: snapshot.data![index],
                  ),
                );
              })
          : Center(child: CircularProgressIndicator())),
    ));
  }
}
