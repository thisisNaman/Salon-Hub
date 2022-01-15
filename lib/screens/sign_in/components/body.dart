import 'package:flutter/material.dart';
import 'package:salon_hub/components/no_account_text.dart';
import 'package:salon_hub/constants.dart';
import 'package:salon_hub/screens/sign_up/sign_up_screen.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../../size_config.dart';
import 'sign_form.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

final PanelController _controller = PanelController();

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    SizedBox(height: SizeConfig.screenHeight * 0.04),
                    Text(
                      "Salon Hub",
                      style: TextStyle(
                        letterSpacing: 1.5,
                        color: Colors.white,
                        fontSize: getProportionateScreenWidth(30),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.04),
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                        color: kPrimaryLightColor,
                        fontSize: getProportionateScreenWidth(26),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Sign in with your email and password.",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.08),
                    SignForm(),
                    SizedBox(height: SizeConfig.screenHeight * 0.08),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don’t have an account? ",
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(16),
                              color: Colors.white54),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _controller.open();
                            });
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(16),
                                color: kPrimaryColor),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SlidingUpPanel(
              minHeight: 0,
              backdropColor: Colors.black38,
              backdropEnabled: true,
              controller: _controller,
              borderRadius: BorderRadius.circular(20.0),
              panel: Container(
                decoration: BoxDecoration(
                    color: lightBackgroundColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      splashColor: lightBackgroundColor,
                      onTap: () {
                        Navigator.pushNamed(context, SignUpScreen.routeName,
                            arguments: "true");
                      },
                      child: Container(
                        width: width - 20,
                        padding:
                            EdgeInsets.all(getProportionateScreenWidth(30)),
                        child: const Center(
                          child: Text(
                            'Sign up as Salon',
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    ),
                    InkWell(
                      splashColor: lightBackgroundColor,
                      onTap: () {
                        Navigator.pushNamed(context, SignUpScreen.routeName,
                            arguments: "false");
                      },
                      child: Container(
                        width: width - 20,
                        padding:
                            EdgeInsets.all(getProportionateScreenWidth(30)),
                        child: const Center(
                          child: Text(
                            'Sign up as User',
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              maxHeight: MediaQuery.of(context).size.height / 3,
            )
          ],
        ),
      ),
    );
  }
}
