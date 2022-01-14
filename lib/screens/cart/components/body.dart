import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/svg.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:salon_hub/components/default_button.dart';
import 'package:salon_hub/models/cart.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../../constants.dart';
import 'check_out_card.dart';
import '../../../size_config.dart';
import 'package:salon_hub/helper/snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final PanelController _panelController = PanelController();
  final Razorpay _razorpay = Razorpay();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController numController = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController phoneno = TextEditingController();
  final TextEditingController address = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String description = '';

  _getOrderId(String txnid, String amount) async {}
  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    getDescription();
  }

  void launchRazorPay() {
    var options = {
      'key': dotenv.env['API_KEY'],
      'amount': totalPrice * 100,
      'name': name.text,
      'description': description,
      'timeout': 120,
      'currency': "INR",
      'prefill': {
        'contact': phoneno.text,
        'email': auth.currentUser!.email,
        'notes': address.text,
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      print('$e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    showSnackbar(context,
        'Payment successful \nPayment id: ' + response.paymentId.toString());
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text(
                'Payment successful',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Text('Payment id:\n${response.paymentId.toString()}'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text('Okay'),
                )
              ],
            ));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    String msg = "ERROR: " +
        response.code.toString() +
        " - " +
        jsonDecode(response.message!)['error']['description'];
    showSnackbar(context, msg);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    String msg = "EXTERNAL_WALLET: " + response.walletName!;
    showSnackbar(context, msg);
  }

  void getDescription() {
    for (int i = 0; i < cartItems.length; i++) {
      description += cartItems[i].product.name +
          ' x' +
          cartItems[i].numOfItem.toString() +
          '\t Rs.' +
          cartItems[i].product.price.toString() +
          '\n\n';
    }
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(children: [
      Column(
        children: [
          cartItems.isNotEmpty
              ? const SizedBox(
                  height: 10.0,
                )
              : Container(),
          cartItems.isNotEmpty
              ? const Text(
                  'Swipe left to delete',
                  style: TextStyle(color: Color.fromARGB(255, 107, 138, 168)),
                )
              : Container(),
          cartItems.isNotEmpty
              ? const SizedBox(
                  height: 3.0,
                )
              : Container(),
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20), vertical: 20.0),
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Dismissible(
                      key: Key(cartItems[index].product.id.toString()),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        setState(() {
                          totalPrice -= cartItems[index].product.price *
                              cartItems[index].numOfItem;
                          cartItems.removeAt(index);
                        });
                      },
                      background: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFE6E6),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            const Spacer(),
                            SvgPicture.asset("assets/icons/Trash.svg"),
                          ],
                        ),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 88,
                            child: AspectRatio(
                              aspectRatio: 0.88,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  cartItems[index].product.image_src,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 185,
                                child: Text(
                                  cartItems[index].product.name,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      text:
                                          "\u{20B9} ${cartItems[index].product.price}"
                                              .replaceAllMapped(reg, mathFunc),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: kPrimaryColor),
                                      children: [
                                        TextSpan(
                                            text:
                                                " x${cartItems[index].numOfItem}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  cartItems[index].numOfItem != 1
                                      ? IconButton(
                                          onPressed: () {
                                            setState(() {
                                              cartItems[index].numOfItem--;
                                              totalPrice -= cartItems[index]
                                                  .product
                                                  .price;
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.remove_circle,
                                            color: kPrimaryLightColor,
                                          ))
                                      : IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.remove_circle,
                                            color: Colors.grey,
                                          )),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _displayTextInputDialog(context, index);
                                    },
                                    child:
                                        Text('${cartItems[index].numOfItem}'),
                                  ),
                                  const SizedBox(
                                    width: 10.0,
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.add_circle,
                                      color: kPrimaryLightColor,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        cartItems[index].numOfItem++;
                                        totalPrice +=
                                            cartItems[index].product.price;
                                      });
                                    },
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      )),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: CheckoutCard(
              tPrice: totalPrice,
              pc: _panelController,
            ),
          )
        ],
      ),
      SlidingUpPanel(
        color: Colors.transparent,
        controller: _panelController,
        backdropEnabled: true,
        minHeight: 0,
        maxHeight: 4 * MediaQuery.of(context).size.height / 5,
        panel: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(blurRadius: 20.0, color: lightBackgroundColor)
            ],
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0)),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Email:\n",
                    style: TextStyle(color: kPrimaryColor),
                    children: [
                      TextSpan(
                        text: auth.currentUser!.email,
                        style: const TextStyle(
                            fontSize: 18,
                            overflow: TextOverflow.visible,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                textField(size, "Name", false, name),
                textField(size, "Phone no.", true, phoneno),
                textField(size, "Address", false, address),
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 50.0, horizontal: 50.0),
                  child: DefaultButton(
                    press: launchRazorPay,
                    text: 'Pay  \u{20B9} ' +
                        totalPrice.toString().replaceAllMapped(reg, mathFunc),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    ]);
  }

  Widget textField(Size size, String text, bool isNumerical,
      TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height / 50),
      child: SizedBox(
        height: size.height / 15,
        width: size.width / 1.1,
        child: TextFormField(
          controller: controller,
          keyboardType: isNumerical ? TextInputType.number : null,
          style: const TextStyle(color: kPrimaryLightColor),
          validator: (value) {
            if (value!.length != 10 && isNumerical == true) {
              return "Mobile number must be of 10 digits.";
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            hintText: text,
            labelText: text,
            labelStyle: const TextStyle(color: kPrimaryLightColor),
            hintStyle: TextStyle(color: kPrimaryLightColor.withOpacity(0.5)),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ),
      ),
    );
  }

  Future<Object?> _displayTextInputDialog(
      BuildContext context, int index) async {
    return showGeneralDialog(
        context: context,
        pageBuilder: (context, anim1, anim2) {
          throw Exception();
        },
        transitionBuilder: (context, anim1, anim2, child) {
          return Transform.scale(
            scale: anim1.value,
            child: AlertDialog(
              title: const Text(
                'Input Num of Items',
                style: TextStyle(color: Colors.black),
              ),
              content: TextField(
                onChanged: (value) {
                  setState(() {
                    cartItems[index].numOfItem = int.parse(value);
                    totalPrice =
                        cartItems[index].product.price * int.parse(value);
                  });
                },
                controller: numController,
                decoration: const InputDecoration(hintText: "Input number.."),
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
                  child: const Text('OK'),
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                ),
              ],
            ),
          );
        });
  }
}
