import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String message) async {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    duration: const Duration(milliseconds: 1200),
  ));
}
