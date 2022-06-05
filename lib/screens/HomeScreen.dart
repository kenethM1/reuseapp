import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reuseapp/Widgets/Avatar_Widget.dart';
import 'package:reuseapp/Widgets/Carrousel_Widget.dart';
import 'package:reuseapp/Widgets/ProductsListView_Widget.dart';
import 'package:reuseapp/utils/colors.dart';
import 'package:reuseapp/utils/resourses/AppFontsResourses.dart';

import '../Widgets/Navbar_Widget.dart';
import '../controllers/login_controller.dart';
import '../controllers/products_controller.dart';
import '../controllers/shopping_cart_controller.dart';
import '../utils/translationsHelper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneScreen = MediaQuery.of(context).size;
    var loginController = Get.find<LoginController>();
    var translate = Get.put<TranslationHelper>(TranslationHelper());
    var productsController = Get.put<ProductsController>(ProductsController());
    var shoppingCart = Get.put(ShoppingCartController());
    return Scaffold(
      backgroundColor: ColorsApp.primary,
      endDrawerEnableOpenDragGesture: false,
      drawerEnableOpenDragGesture: false,
      drawer: Drawer(
        elevation: 10,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AvatarWidget(
                      profilePicture: loginController.getUserProfilePicture,
                      size: phoneScreen.width * 0.15),
                  Text(
                    loginController.getUserName,
                    style: AppFontsResourses().nameStyle.copyWith(
                        fontSize: phoneScreen.width * 0.04,
                        color: Colors.white),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: ColorsApp.primary,
              ),
            ),
            ListTile(
              leading: Icon(Icons.add_box),
              title: Text(translate.getTranslated("myOrders")),
              onTap: () {
                Navigator.of(context).pushNamed('myOrders');
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text(translate.getTranslated("shoppingCart")),
              onTap: () {
                Get.offAllNamed("/shoppingCart");
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_basket),
              title: Text(translate.getTranslated("iWantToSell")),
              onTap: () {
                Navigator.of(context).pushNamed('sellerForm');
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text(translate.getTranslated("logout")),
              onTap: () {
                loginController.loggedOut();
                Navigator.of(context).pushNamed("login");
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              NavBarWidget(
                  loginController: loginController, phoneScreen: phoneScreen),
              // Container(
              //   padding: EdgeInsets.only(top: 20, left: 5),
              //   child: Text(translate.getTranslated('welcome_message'),
              //       style: AppFontsResourses()
              //           .secondaryText
              //           .copyWith(color: Colors.grey)),
              // ),
              SizedBox(height: 20),
              SearchBarWidget(phoneScreen: phoneScreen, translate: translate),
              SizedBox(height: 20),
              CarrouselWidget(),
              Obx(() => productsController.isCharging == true
                  ? Center(child: CircularProgressIndicator())
                  : Expanded(child: ProductsListView()))
            ],
          ),
        ),
      ),
    );
  }
}

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    Key? key,
    required this.phoneScreen,
    required this.translate,
  }) : super(key: key);

  final Size phoneScreen;
  final TranslationHelper translate;

  @override
  Widget build(BuildContext context) {
    var productsController = Get.find<ProductsController>();
    return Row(
      children: [
        Spacer(),
        Container(
          transformAlignment: Alignment.centerRight,
          width: phoneScreen.width * 0.9,
          decoration: BoxDecoration(
            color: ColorsApp.primary,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: Colors.black.withOpacity(0.2),
                offset: Offset(0, 20),
              ),
            ],
          ),
          child: Obx(
            (() => TextField(
                  onChanged: (value) => productsController.filterProducs(value),
                  //textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    border: InputBorder.none,
                    hintText: translate.getTranslated('search_hint'),
                    hintStyle: AppFontsResourses().secondaryWhite,
                  ),
                )),
          ),
        ),
      ],
    );
  }
}
