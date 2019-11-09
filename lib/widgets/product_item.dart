import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supershop/models/product.dart';

class ProductItem extends StatelessWidget {
//  final String id;
//  final String imageUrl;
//  final String title;
//
//  ProductItem({this.id, this.imageUrl, this.title});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed('/product-detail', arguments: product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black.withOpacity(.87),
          leading: Consumer<Product>(
              builder: (ctx, product, child) {
                return IconButton(
                  color: Theme
                      .of(context)
                      .accentColor,
                  icon: (product.isFavorite)
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_border),
                  onPressed: () {
                    product.toggleFavorite();
                  },
                );
              }
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).accentColor,
            onPressed: () {},
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
