import 'package:flutter/material.dart';
import 'package:salon_hub/components/custom_suffix_icon.dart';
import 'package:salon_hub/components/form_error.dart';
import 'package:salon_hub/helper/keyboard.dart';
import 'package:salon_hub/helper/snack_bar.dart';
import 'package:salon_hub/screens/forgot_password/forgot_password_screen.dart';
import 'package:salon_hub/screens/login_success/login_success_screen.dart';
import 'package:provider/provider.dart';
import 'package:salon_hub/services/authentication_service.dart';
import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool loading = false;

  String? email;
  String? password;
  bool? remember = false;
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
          Row(
            children: [
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: const Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          !loading
              ? DefaultButton(
                  text: "Continue",
                  press: () async {
                    setState(() {
                      loading = true;
                    });
                    final result =
                        await context.read<AuthenticationService>().signIn(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );
                    if (result == "Signed in") {
                      setState(() {
                        loading = false;
                      });
                      Navigator.pushNamed(
                          context, LoginSuccessScreen.routeName);
                    } else if (result == "not verified") {
                      setState(() {
                        loading = false;
                      });
                      showSnackbar(
                          context, "Please verify first.Link sent on email.");
                    } else {
                      setState(() {
                        loading = false;
                      });
                      showSnackbar(context,
                          "User not registered or the credentials are wrong.");
                    }
                    KeyboardUtil.hideKeyboard(context);
                  },
                )
              : const Center(
                  child: CircularProgressIndicator(
                  color: kPrimaryColor,
                )),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
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
      controller: emailController,
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
      style: TextStyle(color: kPrimaryLightColor),
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
