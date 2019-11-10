import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supershop/providers/products_provider.dart';
import 'package:supershop/widgets/app_drawer.dart';
import 'package:supershop/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var productData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          )
        ],
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: productData.products.length,
        itemBuilder: (_, i) => UserProductItem(productData.products[i]),
      ),
    );
  }
}
