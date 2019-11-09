import 'package:flutter/material.dart';
import 'package:supershop/models/product.dart';
import 'package:supershop/widgets/products_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
      ),
      body: ProductsGrid(),
    );
  }
}
