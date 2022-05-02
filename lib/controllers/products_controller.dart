import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../models/Product.dart';
import 'package:http/http.dart' as http;

import '../utils/restClient.dart';

class ProductsController extends GetxController {
  var products = <Product>[].obs;
  var selectedProduct = Product().obs;
  var isCharging = false.obs;

  void selectProduct(Product product) {
    selectedProduct.value = product;
  }

  Future<List<Product>> getProducts() async {
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
        this.products.value.assignAll(products);
        return products;
      }
      return [];
    }
    return [];
  }

  Future<List<Product>> GetProductByCategory(int id) async {
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
      this.products.value = products;
      update();
      isCharging.value = false;
      return products;
    }
    return [];
  }

  void UpdateProductList(int? id) async {
    if (id != null) {
      await GetProductByCategory(id);
    } else {
      getProducts();
    }
  }
}
