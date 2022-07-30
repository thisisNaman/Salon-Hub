import 'package:flutter/material.dart';
import 'package:salon_hub/constants.dart';

import '../../../size_config.dart';

class TopRoundedContainer extends StatelessWidget {
  const TopRoundedContainer({
    Key? key,
    required this.color,
    required this.child,
  }) : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: getProportionateScreenWidth(20)),
      padding: EdgeInsets.only(top: getProportionateScreenWidth(25)),
      width: double.infinity,
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.white.withOpacity(0.5),
                blurStyle: BlurStyle.outer,
                spreadRadius: -7.0,
                blurRadius: 10.0)
          ]),
      child: child,
    );
  }
}
