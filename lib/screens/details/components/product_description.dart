import 'package:flutter/material.dart';
import 'package:salon_hub/constants.dart';
import 'package:salon_hub/models/product.dart';
import '../../../size_config.dart';

class ProductDescription extends StatefulWidget {
  const ProductDescription({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Details : ',
            style: TextStyle(
                color: kPrimaryLightColor,
                fontWeight: FontWeight.bold,
                fontSize: getProportionateScreenWidth(15.0)),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          child: Text(
            widget.product.description,
            overflow: TextOverflow.visible,
            style: TextStyle(color: Colors.white54),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: 10,
          ),
        ),
      ],
    );
  }
}
