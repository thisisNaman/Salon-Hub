import 'package:flutter/material.dart';
import 'package:salon_hub/size_config.dart';

import 'body.dart';

class ChangePasswordScreen extends StatelessWidget {
  static String routeName = "/changepass";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xffb2936e)),
        backgroundColor: const Color(0xff322310),
        title: const Text(
          "Change Password",
          style: TextStyle(color: Color(0xffb2936e)),
        ),
      ),
      body: Body(),
    );
  }
}
