import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supershop/models/product.dart';
import 'package:supershop/providers/products_provider.dart';

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
                      Navigator.of(context)
                          .pushNamed('/edit-product', arguments: _product.id);
                    }),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () async {
                    try {
                      await Provider.of<ProductsProvider>(context)
                          .deleteProduct(_product.id);
                    } on Exception catch (e) {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Delete failed')),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        Divider()
      ],
    );
  }
}
