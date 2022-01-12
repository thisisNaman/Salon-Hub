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
        TopRoundedContainer(
          color: const Color(0xffDD914F),
          child: Column(
            children: [
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
                color: const Color(0xffDD914F),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 8.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Text(
                          "Rs. ${widget.product.price}",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: getProportionateScreenWidth(20)),
                        ),
                      ),
                    ),
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Padding(
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
                                    product: widget.product, numOfItem: 1));
                                totalPrice += widget.product.price;
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
