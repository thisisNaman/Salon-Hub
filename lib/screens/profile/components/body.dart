import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_hub/helper/snack_bar.dart';
import 'package:salon_hub/screens/change_password/change_password_screen.dart';
import 'package:salon_hub/screens/sign_in/sign_in_screen.dart';
import 'package:salon_hub/services/authentication_service.dart';
import 'package:salon_hub/size_config.dart';
import 'profile_menu.dart';
import 'package:salon_hub/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Body extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Center(
            child: Icon(
              Icons.account_circle_rounded,
              color: Colors.white,
              size: getProportionateScreenWidth(40),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              auth.currentUser!.email.toString(),
              style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 30),
          ProfileMenu(
            text: "Change Password",
            icon: "assets/icons/Lock.svg",
            press: () {
              Navigator.pushNamed(context, ChangePasswordScreen.routeName);
            },
          ),
          const SizedBox(height: 30),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {
              context.read<AuthenticationService>().signOut();
              showSnackbar(context, "Logged Out");
              Navigator.pushNamed(context, SignInScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
