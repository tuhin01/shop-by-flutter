import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supershop/models/product.dart';
import 'package:supershop/providers/products_provider.dart';
import 'package:supershop/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Product> products = Provider.of<ProductsProvider>(context).products;

    return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: products.length,
        itemBuilder: (context, i) {
          return ProductItem(
            id: products[i].id,
            title: products[i].title,
            imageUrl: products[i].imageUrl,
          );
        });
  }
}
