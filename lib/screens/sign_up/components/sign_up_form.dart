import 'package:flutter/material.dart';
import 'package:salon_hub/components/custom_suffix_icon.dart';
import 'package:salon_hub/components/default_button.dart';
import 'package:salon_hub/components/form_error.dart';
import 'package:salon_hub/helper/snack_bar.dart';
import 'package:salon_hub/screens/complete_profile/complete_profile_screen.dart';
import 'package:salon_hub/services/authentication_service.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class SignUpForm extends StatefulWidget {
  final String isSalon;

  const SignUpForm({Key? key, required this.isSalon}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordconfirmController =
      TextEditingController();
  String? email;
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
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConfirmPassFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Continue",
            press: () {
              if ((_passwordController.text.trim() ==
                      _passwordconfirmController.text.trim()) &&
                  _emailController.text.trim() != "" &&
                  _passwordController.text.trim().length > 8) {
                Navigator.pushNamed(context, CompleteProfileScreen.routeName,
                    arguments: [
                      _emailController.text.trim(),
                      _passwordController.text.trim(),
                      widget.isSalon
                    ]);
              } else if (_passwordController.text.trim().length < 8) {
                showSnackbar(
                    context, "Password must be atleast 8 characters long.");
              } else if (_passwordController.text.trim() !=
                  _passwordconfirmController.text.trim()) {
                showSnackbar(context, "Password didn't match");
              } else {
                showSnackbar(context, "Please fill all the fields!");
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildConfirmPassFormField() {
    return TextFormField(
      obscureText: true,
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
      style: const TextStyle(color: kPrimaryLightColor),
      decoration: const InputDecoration(
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        labelStyle: TextStyle(color: kPrimaryLightColor),
        hintStyle: TextStyle(color: kPrimaryLightColor),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: _passwordController,
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
      style: TextStyle(color: kPrimaryLightColor),
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

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      style: const TextStyle(color: kPrimaryLightColor),
      decoration: const InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        labelStyle: TextStyle(color: kPrimaryLightColor),
        hintStyle: TextStyle(color: kPrimaryLightColor),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
