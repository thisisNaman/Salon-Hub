import 'package:flutter/material.dart';
import 'package:salon_hub/constants.dart';
import 'package:salon_hub/size_config.dart';

import 'sign_up_form.dart';

class Body extends StatelessWidget {
  final String isSalon;

  const Body({Key? key, required this.isSalon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                Text(
                  "Salon Hub",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: getProportionateScreenWidth(30),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                Text("Register Account",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(28),
                      fontWeight: FontWeight.bold,
                      color: kPrimaryLightColor,
                      height: 1.5,
                    )),
                const Text(
                  "Complete your details.",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SignUpForm(isSalon: isSalon,),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SizedBox(height: getProportionateScreenHeight(20)),
                Text(
                  'By continuing your confirm that you agree \nwith our Terms and Conditions',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: lightBackgroundColor),
                ),
                const SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
