import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reuseapp/Widgets/Carrousel_Widget.dart';
import 'package:reuseapp/Widgets/ProductsListView_Widget.dart';
import 'package:reuseapp/utils/colors.dart';
import 'package:reuseapp/utils/resourses/AppFontsResourses.dart';

import '../Widgets/Navbar_Widget.dart';
import '../controllers/login_controller.dart';
import '../controllers/products_controller.dart';
import '../utils/TranslationsHelper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneScreen = MediaQuery.of(context).size;
    var loginController = Get.find<LoginController>();
    var translate = TranslationHelper();
    var productsController = Get.put<ProductsController>(ProductsController());
    return Scaffold(
      backgroundColor: ColorsApp.primary,
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
          child: TextField(
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
          ),
        ),
      ],
    );
  }
}
