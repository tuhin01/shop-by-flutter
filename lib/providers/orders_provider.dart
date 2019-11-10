import 'package:flutter/material.dart';
import 'package:supershop/models/cart_product.dart';
import 'package:supershop/models/order.dart';

class OrdersProvider with ChangeNotifier {
  List<Order> _orders;

  List<Order> get orders {
    return List<Order>.of(_orders);
  }

  void addOrder(List<CartProduct> cartProducts, double totalAmount) {
    _orders.insert(
      0,
      Order(
          id: DateTime.now().toString(),
          amount: totalAmount,
          products: cartProducts,
          dateTime: DateTime.now()),
    );
    notifyListeners();
  }
}
