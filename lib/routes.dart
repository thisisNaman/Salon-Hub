import 'package:flutter/widgets.dart';
import 'package:salon_hub/screens/cart/cart_screen.dart';
import 'package:salon_hub/screens/complete_profile/complete_profile_screen.dart';
import 'package:salon_hub/screens/details/details_screen.dart';
import 'package:salon_hub/screens/forgot_password/forgot_password_screen.dart';
import 'package:salon_hub/screens/home/home_screen.dart';
import 'package:salon_hub/screens/login_success/login_success_screen.dart';
import 'package:salon_hub/screens/products/products_screen.dart';
import 'package:salon_hub/screens/profile/profile_screen.dart';
import 'package:salon_hub/screens/sign_in/sign_in_screen.dart';
import 'package:salon_hub/screens/sign_up/sign_up_screen.dart';
import 'package:salon_hub/screens/change_password/change_password_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  ChangePasswordScreen.routeName: (context) => ChangePasswordScreen(),
  ProductsScreen.routeName: (context) => ProductsScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
};
