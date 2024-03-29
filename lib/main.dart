import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supershop/providers/cart_provider.dart';
import 'package:supershop/providers/orders_provider.dart';
import 'package:supershop/providers/products_provider.dart';
import 'package:supershop/screens/cart_screen.dart';
import 'package:supershop/screens/edit_product_screen.dart';
import 'package:supershop/screens/order_screen.dart';
import 'package:supershop/screens/product_detail_screen.dart';
import 'package:supershop/screens/products_overview_screen.dart';
import 'package:supershop/screens/user_products_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ProductsProvider()),
        ChangeNotifierProvider.value(value: CartProvider()),
        ChangeNotifierProvider.value(value: OrdersProvider()),
      ],
      child: ChangeNotifierProvider.value(
        value: ProductsProvider(),
        child: MaterialApp(
          title: 'My Shop',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
          ),
          initialRoute: '/',
          routes: {
            '/': (_) => ProductsOverviewScreen(),
            '/product-detail': (_) => ProductDetailScreen(),
            '/cart': (_) => CartScreen(),
            '/orders': (_) => OrderScreen(),
            '/my-products': (_) => UserProductsScreen(),
            '/edit-product': (_) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
