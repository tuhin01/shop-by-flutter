import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supershop/providers/cart_provider.dart';
import 'package:supershop/providers/products_provider.dart';
import 'package:supershop/widgets/app_drawer.dart';
import 'package:supershop/widgets/badge.dart';
import 'package:supershop/widgets/products_grid.dart';

enum FilterOptions { Favorite, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorite = false;
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isInit = false;
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductsProvider>(context).getProducts().then((_) {
        Provider.of<ProductsProvider>(context).getProducts().then((_) {
          setState(() {
            _isLoading = false;
          });
        });
      }).catchError((error) {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return AlertDialog(
              title: Text('Something went wrong'),
              content: Text(error.toString()),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    setState(() {
                      _isLoading = false;
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //final cart = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text('My Shop'),
          actions: <Widget>[
            Consumer<CartProvider>(
              builder: (_, cart, child) =>
                  Badge(
                    child: child,
                    value: cart.itemsCount.toString(),
                  ),
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed('/cart');
                },
              ),
            ),
            PopupMenuButton(
              onSelected: (FilterOptions option) {
                setState(() {
                  if (option == FilterOptions.Favorite) {
                    _showOnlyFavorite = true;
                  } else {
                    _showOnlyFavorite = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) =>
              [
                PopupMenuItem(
                  child: Text('Only Favorites'),
                  value: FilterOptions.Favorite,
                ),
                PopupMenuItem(
                  child: Text('Show All'),
                  value: FilterOptions.All,
                ),
              ],
            ),
          ],
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ProductsGrid(_showOnlyFavorite),
        drawer: AppDrawer());
  }
}
