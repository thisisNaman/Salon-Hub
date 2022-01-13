import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:salon_hub/components/custom_suffix_icon.dart';
import 'package:salon_hub/components/default_button.dart';
import 'package:salon_hub/components/form_error.dart';
import 'package:salon_hub/helper/snack_bar.dart';
import 'package:salon_hub/services/authentication_service.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordconfirmController =
      TextEditingController();
  final TextEditingController _oldPasswordConfirmController =
      TextEditingController();
  String? old_password;
  String? password;
  String? confirm_password;
  final List<String?> errors = [];
  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: getProportionateScreenHeight(30)),
                      buildOldPassFormField(),
                      SizedBox(height: getProportionateScreenHeight(30)),
                      buildPasswordFormField(),
                      SizedBox(height: getProportionateScreenHeight(30)),
                      buildConfirmPassFormField(),
                      FormError(errors: errors),
                      SizedBox(height: getProportionateScreenHeight(40)),
                      SizedBox(height: getProportionateScreenHeight(40)),
                      DefaultButton(
                          text: "Change Password",
                          press: () async {
                            if (_passwordController.text.trim() ==
                                _passwordconfirmController.text.trim()) {
                              User? user =
                                  await FirebaseAuth.instance.currentUser;
                              user!
                                  .updatePassword(
                                      _passwordconfirmController.text.trim())
                                  .then((_) {
                                showSnackbar(
                                    context, "Password changed successfully.");
                              }).catchError((error) {
                                showSnackbar(context,
                                    'Login time expired. Please login again to change password.');
                              });
                            } else {
                              showSnackbar(context,
                                  'Passwords don\'t match. Please try again.');
                            }
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildOldPassFormField() {
    return TextFormField(
      cursorColor: Color(0xffb2936e),
      obscureText: false,
      controller: _oldPasswordConfirmController,
      onSaved: (newValue) => old_password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == old_password) {
          removeError(error: kMatchPassError);
        }
        old_password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      style: TextStyle(color: kPrimaryLightColor),
      decoration: const InputDecoration(
        labelStyle: TextStyle(color: kPrimaryLightColor),
        hintStyle: TextStyle(color: kPrimaryColor),
        labelText: "Old Password",
        hintText: "Enter your old password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildConfirmPassFormField() {
    return TextFormField(
      obscureText: true,
      cursorColor: kPrimaryColor,
      controller: _passwordconfirmController,
      onSaved: (newValue) => confirm_password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == confirm_password) {
          removeError(error: kMatchPassError);
        }
        confirm_password = value;
      },
      style: TextStyle(color: kPrimaryColor),
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        labelStyle: TextStyle(color: kPrimaryLightColor),
        hintStyle: TextStyle(color: kPrimaryLightColor),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/Lock.svg",
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: _passwordController,
      cursorColor: kPrimaryLightColor,
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      style: TextStyle(color: kPrimaryLightColor),
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        labelStyle: TextStyle(color: kPrimaryLightColor),
        hintStyle: TextStyle(color: kPrimaryLightColor),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }
}
