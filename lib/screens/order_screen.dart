import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:supershop/providers/orders_provider.dart';
import 'package:supershop/widgets/app_drawer.dart';
import 'package:supershop/widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var ordersData = Provider.of<OrdersProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Orders')),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: ordersData.orders.length,
        itemBuilder: (ctx, i) {
          return OrderItem(ordersData.orders[i]);
        },
      ),
    );
  }
}
