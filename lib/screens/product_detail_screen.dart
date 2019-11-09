import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supershop/models/product.dart';
import 'package:supershop/providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String productId =
        ModalRoute.of(context).settings.arguments as String;

    Product _product = Provider.of<ProductsProvider>(
      context,
      listen: false,
    ).findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(_product.title),
      ),
      body: Center(
        child: Text(_product.title),
      ),
    );
  }
}
