import 'package:flutter/material.dart';

import 'components/body.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = "/sign_up";
  @override
  Widget build(BuildContext context) {
    final String isSalon =
        ModalRoute.of(context)!.settings.arguments.toString();
    return Scaffold(
      body: Body(
        isSalon: isSalon,
      ),
    );
  }
}
