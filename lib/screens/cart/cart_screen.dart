import 'package:flutter/material.dart';
import 'package:salon_hub/models/cart.dart';

import 'components/body.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Column(
        children: [
          const Text(
            "Your Cart",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "${cartItems.length} items",
            style: const TextStyle(color: Colors.white, fontSize: 15.0),
          ),
        ],
      ),
    );
  }
}
