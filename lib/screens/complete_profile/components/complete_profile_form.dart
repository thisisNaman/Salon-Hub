import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salon_hub/components/custom_suffix_icon.dart';
import 'package:salon_hub/components/default_button.dart';
import 'package:salon_hub/components/form_error.dart';
import 'package:salon_hub/helper/snack_bar.dart';
import 'package:salon_hub/screens/login_success/login_success_screen.dart';
import 'package:salon_hub/screens/sign_up/sign_up_screen.dart';

import '../../../constants.dart';
import '../../../services/authentication_service.dart';
import '../../../size_config.dart';

class CompleteProfileForm extends StatefulWidget {
  final List<String> args;

  const CompleteProfileForm({Key? key, required this.args}) : super(key: key);
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController salonNameController = TextEditingController();
  final TextEditingController phoneNumController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? address;
  bool loading = false;

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
      child: SingleChildScrollView(
        child: Column(
          children: [
            widget.args[2] == 'true' ? buildSalonNameFormField() : Container(),
            widget.args[2] == 'true'
                ? SizedBox(height: getProportionateScreenHeight(30))
                : Container(),
            buildFirstNameFormField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            buildLastNameFormField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            buildPhoneNumberFormField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            buildAddressFormField(),
            FormError(errors: errors),
            SizedBox(height: getProportionateScreenHeight(40)),
            !loading
                ? DefaultButton(
                    text: "Continue",
                    press: () async {
                      if (firstNameController.text != "" &&
                          lastNameController.text != "" &&
                          (widget.args[2] == "false" ||
                              salonNameController.text != "") &&
                          phoneNumController.text.trim().length == 10) {
                        setState(() {
                          loading = true;
                        });
                        final result = await context
                            .read<AuthenticationService>()
                            .signUp(
                                email: widget.args[0],
                                password: widget.args[1],
                                firstName: firstNameController.text.trim(),
                                lastName: lastNameController.text.trim(),
                                phonenum: phoneNumController.text.trim(),
                                address: addressController.text.trim(),
                                salonName: salonNameController.text.trim());

                        if (result == "Verification link sent") {
                          setState(() {
                            loading = false;
                          });
                          context.read<AuthenticationService>().signOut();

                          showSnackbar(context, result);
                        } else {
                          showSnackbar(context, result);
                        }
                      } else if (phoneNumController.text.trim().length != 10) {
                        showSnackbar(
                            context, "Phone number must be of length 10.");
                      } else {
                        showSnackbar(context, 'Please fill all the fields.');
                      }
                    },
                  )
                : const Center(
                    child: CircularProgressIndicator(color: kPrimaryColor),
                  ),
          ],
        ),
      ),
    );
  }

  TextFormField buildSalonNameFormField() {
    return TextFormField(
      controller: salonNameController,
      onSaved: (newValue) => lastName = newValue,
      style: const TextStyle(color: kPrimaryLightColor),
      decoration: const InputDecoration(
        labelText: "Salon name",
        hintText: "Enter your salon name",
        labelStyle: TextStyle(color: kPrimaryColor),
        hintStyle: TextStyle(color: kPrimaryLightColor),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      controller: addressController,
      onSaved: (newValue) => address = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      style: const TextStyle(color: kPrimaryLightColor),
      decoration: InputDecoration(
        labelText: "Address",
        hintText: widget.args[2] == "true"
            ? "Enter your salon address"
            : "Enter your address",
        labelStyle: const TextStyle(color: kPrimaryColor),
        hintStyle: const TextStyle(color: kPrimaryLightColor),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSuffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      controller: phoneNumController,
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      style: const TextStyle(color: kPrimaryLightColor),
      decoration: const InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your phone number",
        labelStyle: TextStyle(color: kPrimaryColor),
        hintStyle: TextStyle(color: kPrimaryLightColor),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      controller: lastNameController,
      onSaved: (newValue) => lastName = newValue,
      style: const TextStyle(color: kPrimaryLightColor),
      decoration: const InputDecoration(
        labelText: "Last Name",
        hintText: "Enter your last name",
        labelStyle: TextStyle(color: kPrimaryColor),
        hintStyle: TextStyle(color: kPrimaryLightColor),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      controller: firstNameController,
      onSaved: (newValue) => firstName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      style: const TextStyle(color: kPrimaryLightColor),
      decoration: const InputDecoration(
        labelText: "First Name",
        hintText: "Enter your first name",
        labelStyle: TextStyle(color: kPrimaryColor),
        hintStyle: TextStyle(color: kPrimaryLightColor),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
