import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salon_hub/constants.dart';

import '../../../size_config.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20), vertical: 8.0),
        child: Row(
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
          ],
        ),
      ),
    );
  }
}
