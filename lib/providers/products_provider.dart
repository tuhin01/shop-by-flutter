import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:supershop/models/product.dart';
import 'package:http/http.dart' as http;

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get products {
    return List<Product>.of(_items);
  }

  Future<void> getProducts() async {
    print('Call getProducts');
    const url = 'https://flash-chat-10728.firebaseio.com/products.json';
    try {
      final List<Product> nn = [];
      var response = await http.get(url);
      var productsData = jsonDecode(response.body) as Map<String, dynamic>;
      productsData.forEach((productId, product) {
        nn.add(
          Product(
            id: productId,
            title: product['title'],
            description: product['description'],
            price: product['price'],
            imageUrl: product['imageUrl'],
            isFavorite: product['isFavorite'],
          ),
        );
      });
      _items = nn;
      notifyListeners();
    } on Exception catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> addProduct(Product product) async {
    String url = 'https://flash-chat-10728.firebaseio.com/products.json';

    try {
      var response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'price': product.price,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'isFavorite': product.isFavorite
          }));

      var id = jsonDecode(response.body)['name'];
      Product _product = Product(
        id: id,
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.add(_product);
      notifyListeners();
    } on Exception catch (e) {
      throw e;
    }
  }

  void editProduct(String productId, Product product) {
    final index = _items.indexWhere((prod) => prod.id == productId);
    _items[index] = product;
  }

  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  List<Product> get favoriteProducts {
    return _items.where((product) => product.isFavorite).toList();
  }

  void deleteProduct(String id) {
    _items.removeWhere((product) => product.id == id);
    notifyListeners();
  }
}
