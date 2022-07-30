import 'package:flutter/material.dart';
import 'package:salon_hub/components/default_button.dart';
import 'package:salon_hub/constants.dart';
import 'package:salon_hub/models/product.dart';
import 'package:salon_hub/size_config.dart';
import 'package:salon_hub/models/cart.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatefulWidget {
  final Product product;

  const Body({Key? key, required this.product}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String addCartText = 'Add to Cart';
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductImages(product: widget.product),
        Stack(
          children: [
            TopRoundedContainer(
              color: lightBackgroundColor,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20)),
                    child: Text(
                      widget.product.name,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  widget.product.description != ''
                      ? ProductDescription(
                          product: widget.product,
                        )
                      : Container(),
                  TopRoundedContainer(
                    color: lightBackgroundColor,
                    child: Column(
                      children: [
                        TopRoundedContainer(
                          color: Colors.white,
                          child: Stack(
                            children: [
                              const Image(
                                image: AssetImage('assets/images/cart.jpg'),
                                fit: BoxFit.contain,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: SizeConfig.screenWidth * 0.15,
                                  right: SizeConfig.screenWidth * 0.15,
                                  bottom: getProportionateScreenWidth(40),
                                  top: getProportionateScreenWidth(15),
                                ),
                                child: DefaultButton(
                                  text: addCartText,
                                  press: () {
                                    setState(() {
                                      if (addCartText == 'Add to Cart') {
                                        cartItems.add(Cart(
                                            product: widget.product,
                                            numOfItem: 1));
                                        totalPrice += widget.product.finalPrice;
                                        addCartText = 'Remove from Cart';
                                      } else {
                                        cartItems.removeWhere((element) =>
                                            element.product == widget.product);
                                        addCartText = 'Add to Cart';
                                      }
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 12,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                decoration: BoxDecoration(
                    color: Colors.green,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.greenAccent,
                          blurRadius: 50.0,
                          offset: Offset(0, 2))
                    ],
                    borderRadius: BorderRadius.circular(12.0)),
                child: Row(
                  children: [
                    Text(
                      '\u{20B9} ${widget.product.finalPrice}'
                          .replaceAllMapped(reg, mathFunc),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: getProportionateScreenHeight(23),
                        color: Colors.white,
                      ),
                    ),
                    widget.product.discount != 0
                        ? SizedBox(
                            width: getProportionateScreenHeight(6),
                          )
                        : Container(),
                    widget.product.discount != 0
                        ? Text(
                            '\u{20B9} ${widget.product.price}'
                                .replaceAllMapped(reg, mathFunc),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontWeight: FontWeight.bold,
                              fontSize: getProportionateScreenHeight(13),
                              color: Colors.greenAccent,
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
