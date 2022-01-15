import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_hub/constants.dart';
import 'package:salon_hub/helper/snack_bar.dart';
import 'package:salon_hub/screens/change_password/change_password_screen.dart';
import 'package:salon_hub/screens/sign_in/sign_in_screen.dart';
import 'package:salon_hub/services/authentication_service.dart';
import 'package:salon_hub/size_config.dart';
import 'profile_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

final TextEditingController phoneController = TextEditingController();
final TextEditingController nameController = TextEditingController();
final TextEditingController streetAddressController = TextEditingController();
final TextEditingController districtController = TextEditingController();
final TextEditingController stateController = TextEditingController();
final TextEditingController pincodeController = TextEditingController();

class _BodyState extends State<Body> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  auth.currentUser!.displayName.toString() != ""
                      ? auth.currentUser!.displayName.toString()
                      : auth.currentUser!.email.toString(),
                  style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () {
                      _displayChangeDialog(context, 1, 'Change name');
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: kPrimaryColor,
                    )),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ProfileMenu(
            text: "Change Password",
            icon: "assets/icons/Lock.svg",
            press: () {
              Navigator.pushNamed(context, ChangePasswordScreen.routeName);
            },
          ),
          const SizedBox(height: 20),
          ProfileMenu(
            text: "Change Phone number",
            icon: "assets/icons/Phone.svg",
            press: () {
              _displayChangeDialog(context, 2, 'Change phone number');
            },
          ),
          const SizedBox(height: 20),
          ProfileMenu(
            text: "Change Address",
            icon: "assets/icons/Location point.svg",
            press: () {
              _displayChangeDialog(context, 3, 'Change address');
            },
          ),
          const SizedBox(height: 20),
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

  Future<Object?> _displayChangeDialog(
      BuildContext context, int index, String txt) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding: EdgeInsets.all(30),
            title: Text(
              txt,
              style: const TextStyle(color: Colors.black),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    onChanged: (value) async {
                      if (index == 1) {
                        await auth.currentUser!
                            .updateDisplayName(nameController.text);
                      } else if (index == 2) {
                        await firestore
                            .collection('userData')
                            .doc(uid)
                            .update({'phoneno': phoneController.text.trim()});
                      } else if (index == 3) {
                        await firestore.collection('userData').doc(uid).update({
                          'streetAddress': streetAddressController.text.trim()
                        });
                      }
                      setState(() {});
                    },
                    keyboardType:
                        index == 2 ? TextInputType.phone : TextInputType.text,
                    controller: index == 1
                        ? nameController
                        : index == 2
                            ? phoneController
                            : streetAddressController,
                    decoration: InputDecoration(
                        hintText: index != 3 ? "Enter.." : "Street Address.."),
                  ),
                  index == 3
                      ? const SizedBox(
                          height: 10.0,
                        )
                      : Container(),
                  index == 3
                      ? TextField(
                          onChanged: (value) async {
                            await firestore
                                .collection('userData')
                                .doc(uid)
                                .update({
                              'district': districtController.text.trim()
                            });
                          },
                          controller: districtController,
                          decoration:
                              const InputDecoration(hintText: "District"),
                        )
                      : Container(),
                  index == 3
                      ? const SizedBox(
                          height: 10.0,
                        )
                      : Container(),
                  index == 3
                      ? TextField(
                          onChanged: (value) async {
                            await firestore
                                .collection('userData')
                                .doc(uid)
                                .update({'state': stateController.text.trim()});
                          },
                          controller: stateController,
                          decoration: const InputDecoration(hintText: "State"),
                        )
                      : Container(),
                  index == 3
                      ? const SizedBox(
                          height: 10.0,
                        )
                      : Container(),
                  index == 3
                      ? TextField(
                          keyboardType: TextInputType.phone,
                          onChanged: (value) async {
                            await firestore
                                .collection('userData')
                                .doc(uid)
                                .update(
                                    {'pincode': pincodeController.text.trim()});
                          },
                          controller: pincodeController,
                          decoration:
                              const InputDecoration(hintText: "Pincode"),
                        )
                      : Container(),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              TextButton(
                child: const Text('Change'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }
}
