import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salon_hub/constants.dart';

import '../../../models/product.dart';
import '../../../size_config.dart';

class CustomAppBar extends StatefulWidget {
  final Product product;

  const CustomAppBar({Key? key, required this.product}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20), vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: getProportionateScreenWidth(40),
              width: getProportionateScreenWidth(40),
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  primary: kPrimaryColor,
                  backgroundColor: kPrimaryColor,
                  padding: EdgeInsets.zero,
                ),
                onPressed: () => Navigator.pop(context),
                child: SvgPicture.asset(
                  "assets/icons/Back ICon.svg",
                  color: Colors.white,
                  height: 15,
                ),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
              decoration: BoxDecoration(
                  color: Colors.yellow.shade700,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.yellowAccent,
                        blurRadius: 50.0,
                        offset: Offset(0, 2))
                  ],
                  borderRadius: BorderRadius.circular(12.0)),
              child: Text(
                '${widget.product.discount}% off'
                    .replaceAllMapped(reg, mathFunc),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: getProportionateScreenHeight(23),
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
