import 'package:flutter/material.dart';
import 'package:salon_hub/constants.dart';

void showSnackbar(BuildContext context, String message) async {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    duration: const Duration(milliseconds: 1200),
    behavior: SnackBarBehavior.floating,
    backgroundColor: lightBackgroundColor,
  ));
}
