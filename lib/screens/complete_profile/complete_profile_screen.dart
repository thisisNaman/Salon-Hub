import 'package:flutter/material.dart';

import 'components/body.dart';

class CompleteProfileScreen extends StatelessWidget {
  static String routeName = "/complete_profile";
  @override
  Widget build(BuildContext context) {
    List<String> args = ModalRoute.of(context)!.settings.arguments as List<String>;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Body(
        args: args,
      ),
    );
  }
}
