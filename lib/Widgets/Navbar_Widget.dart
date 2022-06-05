import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:reuseapp/Widgets/Avatar_Widget.dart';
import 'package:reuseapp/Widgets/Shopping_Cart_Modal_Widget.dart';

import '../controllers/login_controller.dart';
import '../controllers/shopping_cart_controller.dart';
import '../utils/colors.dart';
import '../utils/resourses/AppFontsResourses.dart';

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
    var shoppingCart = Get.find<ShoppingCartController>();
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: ColorsApp.primary,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          )),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () => Scaffold.of(context).openDrawer(),
              enableFeedback: true,
              hoverColor: ColorsApp.primary,
              splashColor: ColorsApp.primary,
              child: AvatarWidget(
                profilePicture: loginController.getUserProfilePicture,
                size: 30,
              ),
            ),
            SizedBox(width: phoneScreen.width * 0.03),
            Obx(() => Text(
                  loginController.user.value.firstName ?? "",
                  style: AppFontsResourses().secondaryWhite,
                  overflow: TextOverflow.ellipsis,
                )),
            Spacer(),
            loginController.userIsSeller
                ? IconButton(
                    onPressed: () =>
                        Navigator.of(context).pushNamed('addProduct'),
                    icon: Icon(Icons.add, color: Colors.white))
                : Container(),
            Obx(
              () => Tooltip(
                key: GlobalKey(),
                triggerMode: TooltipTriggerMode.manual,
                decoration: BoxDecoration(
                  color: ColorsApp.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                enableFeedback: true,
                showDuration: Duration(milliseconds: 1500),
                message:
                    "L ${shoppingCart.addedProducts.value.fold<double>(0, (previousValue, element) => previousValue + double.parse(element.price.toString())).toString()}",
                child: Badge(
                  animationType: BadgeAnimationType.scale,
                  showBadge: shoppingCart.addedProducts.length > 0,
                  elevation: 10,
                  badgeColor: Colors.white,
                  position: BadgePosition.topEnd(top: 0, end: 0),
                  badgeContent:
                      Text(shoppingCart.addedProducts.length.toString()),
                  child: IconButton(
                      onPressed: () {
                        showDialog(
                            useSafeArea: true,
                            barrierDismissible: true,
                            barrierColor: Colors.black.withOpacity(0.5),
                            context: context,
                            builder: (_) => AlertDialog(
                                scrollable: true,
                                content: ShoppingCartModalWidget()));
                      },
                      icon: Icon(Icons.shopping_cart_outlined,
                          color: Colors.white)),
                ),
              ),
            ),
          ]),
    );
  }
}
