import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:reuseapp/models/Product.dart';
import 'package:reuseapp/utils/translationsHelper.dart';

class ShoppingCartController extends GetxController {
  var addedProducts = <Product>[].obs;

  AddProductToList(Product product) {
    if (isAdded(product)) {
      return TranslationHelper().getTranslated("already_added");
    }
    addedProducts.add(product);
  }

  isAdded(Product product) {
    return addedProducts.any((productList) => productList.id == product.id);
  }

  RemoveProductFromList(Product product) {
    if (isAdded(product)) {
      var productToRemove = addedProducts
          .firstWhere((productList) => productList.id == product.id);
      addedProducts.remove(productToRemove);
      notifyChildrens();
      update();
    }
  }
}
