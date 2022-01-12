import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salon_hub/constants.dart';

import '../../../size_config.dart';

class CustomAppBar extends StatelessWidget {
  @override
  // AppBar().preferredSize.height provide us the height that appy on our app bar
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
                  backgroundColor: Color(0xffDD914F),
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
            // Container(
            //   padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(14),
            //   ),
            //   child: Row(
            //     children: [
            //       Text(
            //         "$rating",
            //         style: const TextStyle(
            //           fontSize: 14,
            //           fontWeight: FontWeight.w600,
            //         ),
            //       ),
            //       const SizedBox(width: 5),
            //       SvgPicture.asset("assets/icons/Star Icon.svg"),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
