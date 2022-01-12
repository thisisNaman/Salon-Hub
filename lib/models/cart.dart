import 'product.dart';

int totalPrice = 0;

class Cart {
  final Product product;
  int numOfItem;

  Cart({required this.product, required this.numOfItem});
}

List<Cart> cartItems = [];
