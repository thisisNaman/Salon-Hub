import 'package:flutter/material.dart';

import 'components/body.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static String routeName = "/forgot_password";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff322310),
        iconTheme: IconThemeData(color: Color(0xff322310)),
      ),
      body: Body(),
    );
  }
}
