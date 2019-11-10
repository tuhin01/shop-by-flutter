import 'package:flutter/material.dart';
import 'package:supershop/models/product.dart';

class UserProductItem extends StatelessWidget {
  final Product _product;

  UserProductItem(this._product);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(_product.title),
          leading:
              CircleAvatar(backgroundImage: NetworkImage(_product.imageUrl)),
          trailing: Container(
            width: 100.0,
            child: Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                          '/edit-product', arguments: _product);
                    }),
                IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {}),
              ],
            ),
          ),
        ),
        Divider()
      ],
    );
  }
}
