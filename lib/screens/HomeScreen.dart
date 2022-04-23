import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reuseapp/utils/colors.dart';
import 'package:reuseapp/utils/resourses/AppFontsResourses.dart';

import '../controllers/login_controller.dart';
import '../utils/TranslationsHelper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneScreen = MediaQuery.of(context).size;
    var loginController = Get.find<LoginController>();
    var translate = TranslationHelper();
    return Scaffold(
      backgroundColor: ColorsApp.primary,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              NavBarWidget(
                  loginController: loginController, phoneScreen: phoneScreen),
              Container(
                width: phoneScreen.width,
                padding: EdgeInsets.only(top: 20, left: 5),
                child: Text(translate.getTranslated('welcome_message'),
                    style: AppFontsResourses()
                        .secondaryText
                        .copyWith(color: Colors.grey)),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Spacer(),
                  Container(
                    transformAlignment: Alignment.centerRight,
                    width: phoneScreen.width * 0.9,
                    decoration: BoxDecoration(
                      color: ColorsApp.primary,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30)),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavBarWidget extends StatelessWidget {
  const NavBarWidget({
    Key? key,
    required this.loginController,
    required this.phoneScreen,
  }) : super(key: key);

  final LoginController loginController;
  final Size phoneScreen;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: ColorsApp.primary,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          )),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        CircleAvatar(
          child: Icon(Icons.person, color: ColorsApp.secondary),
          backgroundColor: Colors.white,
          radius: 20,
        ),
        SizedBox(width: 20),
        Obx(() => Flexible(
              child: Text(
                loginController.user.value.firstName ?? "",
                style: AppFontsResourses().secondaryWhite,
                overflow: TextOverflow.ellipsis,
              ),
            )),
        Spacer(),
        IconButton(
            onPressed: () => {}, icon: Icon(Icons.add, color: Colors.white)),
        IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart_outlined, color: Colors.white)),
      ]),
    );
  }
}
