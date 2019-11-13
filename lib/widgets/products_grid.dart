import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supershop/models/product.dart';
import 'package:supershop/providers/products_provider.dart';
import 'package:supershop/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool _showFavorites;

  ProductsGrid(this._showFavorites);

  @override
  Widget build(BuildContext context) {
    var productsData = Provider.of<ProductsProvider>(context);
    List<Product> products =
    _showFavorites ? productsData.favoriteProducts : productsData.products;
    print('here');
    print(products);
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
          return ChangeNotifierProvider.value(
            value: products[i],
            child: ProductItem(),
          );
        });
  }
}
