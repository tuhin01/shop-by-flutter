import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:supershop/models/custom_exception.dart';
import 'package:supershop/models/product.dart';
import 'package:http/http.dart' as http;

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get products {
    return List<Product>.of(_items);
  }

  Future<void> getProducts() async {
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
    const url = 'https://flash-chat-10728.firebaseio.com/products.json';

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

  Future<void> editProduct(String productId, Product product) async {
    final index = _items.indexWhere((prod) => prod.id == productId);
    if (index >= 0) {
      try {
        final url =
            'https://flash-chat-10728.firebaseio.com/products/$productId.json';
        await http.patch(url,
            body: json.encode({
              'title': product.title,
              'description': product.description,
              'price': product.price,
              'imageUrl': product.imageUrl
            }));
        _items[index] = product;
        notifyListeners();
      } on Exception catch (e) {
        throw e;
      }
    }
  }

  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  List<Product> get favoriteProducts {
    return _items.where((product) => product.isFavorite).toList();
  }

  Future<void> deleteProduct(String id) async {
    final url = 'https://flash-chat-10728.firebaseio.com/products/$id.json';
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      throw CustomException('Could not delete the product.');
    }
    _items.removeWhere((product) => product.id == id);
    notifyListeners();
  }
}
