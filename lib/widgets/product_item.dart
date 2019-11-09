import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String title;

  ProductItem({this.id, this.imageUrl, this.title});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed('/product-detail', arguments: id);
          },
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black.withOpacity(.87),
          leading: IconButton(
            color: Theme.of(context).accentColor,
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).accentColor,
            onPressed: () {},
          ),
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
