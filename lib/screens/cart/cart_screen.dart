import 'package:flutter/material.dart';
import 'package:salon_hub/models/cart.dart';

import 'components/body.dart';

class CartScreen extends StatefulWidget {
  static String routeName = "/cart";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Your Cart",
            style: TextStyle(color: Colors.white),
          ),
          Row(
            children: [
              cartItems.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          cartItems.clear();
                          totalPrice = 0;
                        });
                      },
                      icon: const Icon(Icons.delete_forever))
                  : Container(),
              const SizedBox(
                width: 10.0,
              ),
              Text(
                cartItems.length > 1
                    ? "${cartItems.length} items"
                    : "${cartItems.length} item",
                style: const TextStyle(color: Colors.white, fontSize: 15.0),
              ),
            ],
          )
        ],
      ),
    );
  }
}
