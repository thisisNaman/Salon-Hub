import 'package:flutter/material.dart';
import 'package:salon_hub/screens/sign_up/sign_up_screen.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../constants.dart';
import '../size_config.dart';

class NoAccountText extends StatefulWidget {
  final PanelController controller;
  const NoAccountText({
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  State<NoAccountText> createState() => _NoAccountTextState();
}

class _NoAccountTextState extends State<NoAccountText> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don’t have an account? ",
          style: TextStyle(
              fontSize: getProportionateScreenWidth(16), color: Colors.white54),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              widget.controller.open();
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
    );
  }
}
