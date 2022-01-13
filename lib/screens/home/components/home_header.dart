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
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Salon Hub',
            style: TextStyle(
                color: Colors.white,
                fontSize: getProportionateScreenWidth(20),
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
