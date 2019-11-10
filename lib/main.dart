import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supershop/providers/cart_provider.dart';
import 'package:supershop/providers/products_provider.dart';
import 'package:supershop/screens/product_detail_screen.dart';
import 'package:supershop/screens/products_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ProductsProvider()),
        ChangeNotifierProvider.value(value: CartProvider()),
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
          },
        ),
      ),
    );
  }
}
