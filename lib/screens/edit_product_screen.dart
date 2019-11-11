import 'package:flutter/material.dart';
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
  var _isInit = true;
  Product _product;

  void _submitForm() {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    _product = Product(
      id: DateTime.now().toString(),
      title: productTitle,
      description: productDescription,
      price: productPrice,
      imageUrl: productImageUrl,
    );

    Provider.of<ProductsProvider>(context, listen: false).addProduct(_product);
    Navigator.of(context).pop();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      var productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _product = Provider.of<ProductsProvider>(context).findById(productId);
        productTitle = _product.title;
        productPrice = _product.price;
        productDescription = _product.description;
        productImageUrl = _product.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save), onPressed: _submitForm),
        ],
      ),
      body: Padding(
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
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
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
    );
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }
}
