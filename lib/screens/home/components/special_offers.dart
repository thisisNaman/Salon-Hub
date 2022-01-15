import 'package:flutter/material.dart';
import 'package:salon_hub/constants.dart';
import 'package:salon_hub/screens/home/components/popular_product.dart';
import 'package:salon_hub/screens/products/products_screen.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: getProportionateScreenWidth(20)),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: "Skin and Hair Care",
            press: () {},
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              Row(
                children: [
                  SpecialOfferCard(
                    image: "assets/images/wella.jpg",
                    category: "",
                    numOfBrands: '120+',
                    press: () {
                      Navigator.pushNamed(context, ProductsScreen.routeName,
                          arguments: '11');
                    },
                  ),
                  SpecialOfferCard(
                    image: "assets/images/vedicline.jpg",
                    category: "",
                    numOfBrands: '300+',
                    press: () {
                      Navigator.pushNamed(context, ProductsScreen.routeName,
                          arguments: '12');
                    },
                  ),
                  SizedBox(width: getProportionateScreenWidth(20)),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  SpecialOfferCard(
                    image: "assets/images/cacau.png",
                    category: "",
                    numOfBrands: '',
                    press: () {
                      Navigator.pushNamed(context, ProductsScreen.routeName,
                          arguments: '13');
                    },
                  ),
                  SpecialOfferCard(
                    image: "assets/images/raaga.jpg",
                    category: "",
                    numOfBrands: '50+',
                    press: () {
                      Navigator.pushNamed(context, ProductsScreen.routeName,
                          arguments: '14');
                    },
                  ),
                  SizedBox(width: getProportionateScreenWidth(20)),
                ],
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: "Tools",
            press: () {},
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SpecialOfferCard(
                image: "assets/images/ikonic.jpg",
                category: "",
                numOfBrands: '80+',
                press: () {
                  Navigator.pushNamed(context, ProductsScreen.routeName,
                      arguments: '21');
                },
              ),
              SpecialOfferCard(
                image: "assets/images/wahl.png",
                category: "",
                numOfBrands: '220+',
                press: () {
                  Navigator.pushNamed(context, ProductsScreen.routeName,
                      arguments: '22');
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        const PopularProducts(),
        const SizedBox(
          height: 20.0,
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
    required this.numOfBrands,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final String numOfBrands;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: getProportionateScreenWidth(156),
          height: getProportionateScreenWidth(100),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: lightBackgroundColor,
                    blurStyle: BlurStyle.outer,
                    spreadRadius: 5.0,
                    blurRadius: 15.0)
              ],
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Stack(
                children: [
                  Image.asset(
                    image,
                    fit: BoxFit.contain,
                    colorBlendMode: BlendMode.lighten,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
