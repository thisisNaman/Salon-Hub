import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salon_hub/screens/cart/cart_screen.dart';
import 'package:salon_hub/screens/home/components/icon_btn_with_counter.dart';
import 'package:salon_hub/screens/home/home_screen.dart';
import 'package:salon_hub/screens/profile/profile_screen.dart';
import 'package:salon_hub/models/cart.dart';
import '../constants.dart';
import '../enums.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6).withOpacity(0.8);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: kPrimaryLightColor.withOpacity(0.5),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/Shop Icon.svg",
                  color: MenuState.home == widget.selectedMenu
                      ? Colors.white
                      : inActiveIconColor,
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, HomeScreen.routeName),
              ),
              IconBtnWithCounter(
                numOfitem: cartItems.length,
                svgSrc: "assets/icons/Cart Icon.svg",
                press: () {
                  setState(() {
                    Navigator.pushNamed(context, CartScreen.routeName);
                  });
                },
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/User Icon.svg",
                  color: MenuState.profile == widget.selectedMenu
                      ? Colors.white
                      : inActiveIconColor,
                ),
                onPressed: () =>
                    Navigator.pushNamed(context, ProfileScreen.routeName),
              ),
            ],
          )),
    );
  }
}
