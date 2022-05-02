import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:reuseapp/controllers/products_controller.dart';
import 'package:reuseapp/models/Category.dart';
import 'package:reuseapp/utils/restClient.dart';
import 'package:http/http.dart' as http;

class CategoriesController extends GetxController {
  var categories = <Category>[].obs;
  var selectedCategory = Category().obs;
  var productsController = Get.put<ProductsController>(ProductsController());

  void selectCategory(Category category) {
    if (selectedCategory.value.id != category.id) {
      selectedCategory.value = category;
      productsController.UpdateProductList(category.id);
    }
  }

  Future<List<Category>> getCategories() async {
    var headers = {
      'Content-Type': 'application/json',
    };
    http.Response response = await restClient(
            url: "/GetAllCategories", method: "GET", headers: headers)
        .execute();
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      var categories = List<Category>.from(
          jsonData.map((model) => Category.fromJson(model)));
      if (categories.isNotEmpty) {
        this.categories.value.assignAll(categories);
        selectedCategory.value = categories.first;
        return categories;
      }
      return [];
    }
    return [];
  }
}
