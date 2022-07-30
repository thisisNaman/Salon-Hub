import 'package:flutter/material.dart';
import 'package:salon_hub/constants.dart';
import 'package:salon_hub/models/product.dart';
import 'package:salon_hub/screens/details/details_screen.dart';
import '../size_config.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
  }) : super(key: key);

  final Product product;

  final double width, aspectRetio;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(width),
        child: ClipRRect(
          child: Banner(
            location: BannerLocation.topEnd,
            message: '${product.discount}% off',
            color: Colors.yellow.shade700,
            textStyle: TextStyle(fontSize: getProportionateScreenHeight(10)),
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(
                context,
                DetailsScreen.routeName,
                arguments: ProductDetailsArguments(product: product),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 1.02,
                    child: FutureBuilder(
                      future: _getImage(context, product.image_src),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Container(
                            child: snapshot.data as Widget?,
                          );
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(
                            color: kPrimaryLightColor,
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    product.name,
                    style: const TextStyle(color: Colors.white),
                    maxLines: 2,
                  ),
                  Row(
                    children: [
                      Text(
                        "\u{20B9}" +
                            product.finalPrice
                                .toString()
                                .replaceAllMapped(reg, mathFunc),
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(18),
                          fontWeight: FontWeight.w600,
                          color: kPrimaryLightColor,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "\u{20B9}" +
                            product.price
                                .toString()
                                .replaceAllMapped(reg, mathFunc),
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(15),
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.lineThrough,
                          color: lightBackgroundColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<Widget?> _getImage(BuildContext context, String imageName) async {
  return ClipRRect(
    borderRadius: BorderRadius.circular(10.0),
    child: Image.network(
      imageName,
      fit: BoxFit.fill,
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return Icon(
          Icons.wifi_off_rounded,
          color: kPrimaryColor,
        );
      },
    ),
  );
}
