import 'package:flutter/material.dart';
import 'package:salon_hub/components/custom_bottom_nav_bar.dart';
import 'package:salon_hub/enums.dart';
import 'components/body.dart';

class ProfileScreen extends StatefulWidget {
  
  static String routeName = "/profile";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff322310),
          iconTheme: const IconThemeData(color: Color(0xffb2936e)),
          title: const Text(
            'Profile',
            style: TextStyle(color: Color(0xffb2936e)),
          ),
        ),
        body: Body(),
        bottomNavigationBar:
            CustomBottomNavBar(selectedMenu: MenuState.profile),
      ),
    );
  }
}
