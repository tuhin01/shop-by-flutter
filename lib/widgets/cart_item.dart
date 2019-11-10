import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:supershop/models/cart.dart';
import 'package:supershop/providers/cart_provider.dart';

class CartItem extends StatelessWidget {
  final Cart _cart;
  final String productId;

  CartItem(this._cart, this.productId);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 1.0),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: FittedBox(child: Text('\$${_cart.price}')),
            ),
          ),
          title: Text('${_cart.title}'),
          subtitle: Text('Total - \$${_cart.quantity * _cart.price}'),
          trailing: Text('${_cart.quantity} x'),
        ),
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Archive',
          color: Colors.blue,
          icon: Icons.archive,
          onTap: () => print('Archive'),
        ),
        IconSlideAction(
          caption: 'Share',
          color: Colors.indigo,
          icon: Icons.share,
          onTap: () => print('Share'),
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'More',
          color: Colors.black45,
          icon: Icons.more_horiz,
          onTap: () => print('More'),
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            print('Deleted');
            Provider.of<CartProvider>(context, listen: false).removeItem(
                productId);
          },
        ),
      ],
    );
  }
}
