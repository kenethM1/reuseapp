import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:reuseapp/Widgets/Avatar_Widget.dart';

import '../controllers/login_controller.dart';
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
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: ColorsApp.primary,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          )),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        AvatarWidget(
          profilePicture: loginController.getUserProfilePicture,
          size: 30,
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
            onPressed: () => Navigator.of(context).pushNamed('addProduct'),
            icon: Icon(Icons.add, color: Colors.white)),
        IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart_outlined, color: Colors.white)),
      ]),
    );
  }
}
