import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salon_hub/components/default_button.dart';
import 'package:salon_hub/constants.dart';
import '../../../size_config.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';

class CheckoutCard extends StatefulWidget {
  CheckoutCard({Key? key, required this.tPrice, required this.pc})
      : super(key: key);
  int tPrice;
  PanelController pc;

  @override
  State<CheckoutCard> createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.tPrice > 0
            ? const Positioned(
                right: 30,
                top: 10,
                child: Image(
                  image: AssetImage('assets/images/payment.png'),
                  width: 100,
                ),
              )
            : Container(),
        Container(
          padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenWidth(25),
            horizontal: getProportionateScreenWidth(30),
          ),
          decoration: BoxDecoration(
              // color: lightBackgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.8),
                  blurStyle: BlurStyle.outer,
                  spreadRadius: -7.0,
                  blurRadius: 10.0,
                )
              ]),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                        splashColor: const Color(0xffb2936e),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          height: getProportionateScreenWidth(40),
                          width: getProportionateScreenWidth(40),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F6F9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SvgPicture.asset("assets/icons/receipt.svg"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 305,
                        child: Text.rich(
                          TextSpan(
                            text: "Total:\n",
                            children: [
                              TextSpan(
                                text: "\u{20B9} " +
                                    widget.tPrice
                                        .toString()
                                        .replaceAllMapped(reg, mathFunc),
                                style: const TextStyle(
                                    fontSize: 18,
                                    overflow: TextOverflow.visible,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      widget.tPrice > 0
                          ? SizedBox(
                              width: getProportionateScreenWidth(170),
                              child: DefaultButton(
                                text: "Check Out",
                                press: () {
                                  widget.pc.open();
                                  setState(() {});
                                },
                              ),
                            )
                          : SizedBox(
                              width: getProportionateScreenWidth(170),
                              child: DefaultButton(
                                text: "Check Out",
                                color: Colors.grey,
                                press: () {},
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
