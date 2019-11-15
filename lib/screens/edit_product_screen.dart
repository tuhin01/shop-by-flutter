import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:supershop/models/product.dart';
import 'package:supershop/providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var productTitle = '';
  double productPrice = 0.0;
  var productDescription = '';
  var productImageUrl = '';
  bool isFavorite;
  var _isInit = true;
  bool _isLoading = false;
  String productId;

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    print(_isLoading);
    Product product = Product(
      id: DateTime.now().toString(),
      title: productTitle,
      description: productDescription,
      price: productPrice,
      imageUrl: productImageUrl,
    );

    try {
      if (productId == null) {
        await Provider.of<ProductsProvider>(context, listen: false)
            .addProduct(product);
      } else {
        Product product = Product(
          id: productId,
          title: productTitle,
          description: productDescription,
          price: productPrice,
          imageUrl: productImageUrl,
          isFavorite: isFavorite,
        );
        print("Edit");
        print(productId);
        await Provider.of<ProductsProvider>(context, listen: false)
            .editProduct(productId, product);
      }
      Navigator.of(context).pop();
    } on Exception catch (e) {
      await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return AlertDialog(
              title: Text('Something went wrong'),
              content: Text(e.toString()),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'),
                ),
              ],
            );
          });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      productId = ModalRoute
          .of(context)
          .settings
          .arguments as String;
      if (productId != null) {
        Product _product =
        Provider.of<ProductsProvider>(context).findById(productId);
        productTitle = _product.title;
        productPrice = _product.price;
        productDescription = _product.description;
        productImageUrl = _product.imageUrl;
        isFavorite = _product.isFavorite;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: productId != null ? Text('Edit Product') : Text('Add Product'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save), onPressed: _submitForm),
        ],
      ),
      body: ModalProgressHUD(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Title'),
                    textInputAction: TextInputAction.next,
                    initialValue: productTitle,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_priceFocusNode);
                    },
                    onSaved: (value) => productTitle = value,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please provide a value!';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Price'),
                    initialValue: productPrice.toString(),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    focusNode: _priceFocusNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context)
                          .requestFocus(_descriptionFocusNode);
                    },
                    onSaved: (value) => productPrice = double.parse(value),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please provide a value!';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number!';
                      }

                      if (double.parse(value) <= 0) {
                        return 'Please enter a number greater than 0!';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Description'),
                    initialValue: productDescription,
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    focusNode: _descriptionFocusNode,
                    onSaved: (value) => productDescription = value,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please provide a value!';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Image Url'),
                    initialValue: productImageUrl,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please provide a value!';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) {
                      _submitForm();
                    },
                    onSaved: (value) => productImageUrl = value,
                  ),
                ],
              ),
            ),
          ),
        ),
        inAsyncCall: _isLoading,
      ),
    );
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }
}
