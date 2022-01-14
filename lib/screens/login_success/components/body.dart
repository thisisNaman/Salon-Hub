import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salon_hub/components/default_button.dart';
import 'package:salon_hub/constants.dart';
import 'package:salon_hub/screens/home/home_screen.dart';
import 'package:salon_hub/size_config.dart';
import 'package:salon_hub/services/authentication_service.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.04),
        Image.asset(
          "assets/images/success.png",
          fit: BoxFit.fill,
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.08),
        Text(
          "Welcome",
          maxLines: 2,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(30),
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        auth.currentUser!.displayName != null
            ? Text(
                "${auth.currentUser!.displayName}",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(30),
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              )
            : Container(),
        const Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth * 0.6,
          child: DefaultButton(
            text: "Go to home",
            press: () {
              Navigator.pushNamed(context, HomeScreen.routeName);
            },
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
