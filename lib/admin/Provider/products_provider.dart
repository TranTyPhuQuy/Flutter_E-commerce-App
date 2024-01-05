import 'dart:convert';

import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/utils/baseurl.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ProductsAdmin extends ChangeNotifier {
  static final List<Product> products = [];

  List<Product> getAllProducts() {
    return products;
  }

  void deleteProduct(int? productId) {
    products.removeWhere((c) => c.productId == productId);
    notifyListeners();
  }

  void _addPro(int productId, String name, double price, String image,
      String description, int cateId, int quantity) {
    products.add(Product(
      productId: productId,
      name: name,
      price: price,
      image: image,
      description: description,
      cateId: cateId,
      featured: 0,
      quantity: quantity,
    ));
    notifyListeners();
  }

  Future addProduct(String name, double price, String description,
      int cateId, int quantity, String image) async {
    Map map = {
      'name': name,
      'price': price.toString(),
      'description': description,
      'cateId': cateId.toString(),
      'quantity': quantity.toString(),
      'image': image,
    };
    http.Response response =
        await http.post(Uri.parse("${baseUrl}products/addProduct"), body: map);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['success']) {
        _addPro(int.parse(data['productId']), name, price, data['image'],
            description, cateId, quantity);
      }
    } else {
      print("Something went wrong");
    }
  }

  Future deleteProductByProductId(int? productId) async {
    http.Response response = await http.delete(Uri.parse(
        "${baseUrl}products/deleteProductByProductId?productId=$productId"));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['success']) {
        deleteProduct(productId);
      }
    } else {
      print("Something went wrong");
    }
  }

  void _updatePro(int productId, String name, double price,
      String description, int quantity) {
    for (var p in products) {
      if (p.productId == productId) {
        p.name = name;
        p.price = price;
        p.description = description;
        p.quantity = quantity;
      }
    }

    notifyListeners();
  }

  Future updateProduct(int productId, String name, double price,
      String description, int quantity) async {
    Map map = {
      'productId': productId.toString(),
      'name': name,
      'price': price.toString(),
      'description': description,
      'quantity': quantity.toString()
    };
    http.Response response = await http
        .post(Uri.parse("${baseUrl}products/updateProduct"), body: map);
    // Check if the response is successful
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['success']) {
        _updatePro(productId, name, price, description, quantity);
      }
    } else {
      // Show an error message
      print("Something went wrong");
    }
  }

  static Future fetchAllProduct() async {
    products.clear();
    http.Response response =
        await http.get(Uri.parse("${baseUrl}products/getProductsById"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      // print(data);
      for (var item in data) {
        products.add(Product(
            productId: item['productId'],
            name: item['name'],
            price: double.parse(item['price']),
            image: item['image'],
            description: item['description'],
            cateId: item['cateId'],
            featured: item['featured'],
            quantity: item['quantity']));
      }
    } else {
      // Show an error message
      print("Something went wrong");
    }
  }
}
