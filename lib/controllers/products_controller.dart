import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../models/Product.dart';
import 'package:http/http.dart' as http;

import '../utils/restClient.dart';

class ProductsController extends GetxController {
  var products = <Product>[].obs;
  var filteredProducts = <Product>[].obs;
  var selectedProduct = Product().obs;
  var isCharging = false.obs;
  var isFiltering = false.obs;

  void selectProduct(Product product) {
    selectedProduct.value = product;
  }

  Future<List<Product>> getProducts(String userId) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    http.Response response = await restClient(
            url: "/GetAllProducts", method: "GET", headers: headers)
        .execute();
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      var products =
          List<Product>.from(jsonData.map((model) => Product.fromJson(model)));
      if (products.isNotEmpty) {
        this.products.value.assignAll(
            products.where((element) => element.sellerAccountId != userId));
        return products;
      }
      return [];
    }
    return [];
  }

  Future<List<Product>> GetProductByCategory(int id, String userId) async {
    isCharging.value = true;
    update();
    var headers = {
      'Content-Type': 'application/json',
    };
    http.Response response = await restClient(
            url: "/GetProductByCategory/$id", method: "GET", headers: headers)
        .execute();
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      var products =
          List<Product>.from(jsonData.map((model) => Product.fromJson(model)));
      this.products.value = products
          .where((element) => element.sellerAccountId.toString() != userId)
          .toList();
      update();
      isCharging.value = false;
      return products;
    }
    return [];
  }

  void UpdateProductList(int? id, String userId) async {
    if (id != null) {
      await GetProductByCategory(id, userId);
    } else {
      getProducts(userId);
    }
  }

  filterProducs(String value) {
    if (value.isEmpty) {
      isFiltering.value = false;
      update();
    } else {
      isFiltering.value = true;
      filteredProducts.value = products
          .where((product) =>
              product.title!.toLowerCase().contains(value.toLowerCase()))
          .toList();
      update();
    }
  }
}
