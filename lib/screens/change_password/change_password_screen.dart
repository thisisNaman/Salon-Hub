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
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text(
          "Change Password",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Body(),
    );
  }
}
