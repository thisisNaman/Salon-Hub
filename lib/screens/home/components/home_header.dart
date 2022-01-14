import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:salon_hub/constants.dart';
import 'package:salon_hub/screens/cart/cart_screen.dart';

import '../../../size_config.dart';
import 'icon_btn_with_counter.dart';
import '../../../components/search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 + 20,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(25.0)),
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage('assets/images/Logo.png'),
            height: 40.0,
            width: 40.0,
          ),
          const SizedBox(
            width: 20.0,
          ),
          Text(
            'Salon Hub',
            style: TextStyle(
                color: kPrimaryColor,
                fontSize: getProportionateScreenWidth(20),
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
