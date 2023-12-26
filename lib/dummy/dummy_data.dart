import 'dart:convert';

import 'package:smart_shop/models/product.dart';
import 'package:smart_shop/utils/baseurl.dart';
import 'package:http/http.dart' as http;

class DummyData {
  static final List<String> sellerImagesLink = [
    'https://images.unsplash.com/photo-1558769132-cb1aea458c5e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
    'https://images.unsplash.com/photo-1603400521630-9f2de124b33b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
    'https://images.unsplash.com/photo-1445205170230-053b83016050?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=871&q=80',
    'https://images.unsplash.com/photo-1582719188393-bb71ca45dbb9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
    // 'assets/featured/pic1.png',
    // 'assets/featured/pic2.png',
  ];

  static final List<String> catalogueTitles = [];

  static final List<String> catalogueImagesLink = [];

  // static final List<String> featured = [
  //   'https://images.unsplash.com/photo-1571513722275-4b41940f54b8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
  //   'https://images.unsplash.com/photo-1552374196-1ab2a1c593e8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
  //   'https://images.unsplash.com/photo-1516257984-b1b4d707412e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
  //   'https://images.unsplash.com/photo-1623880840102-7df0a9f3545b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80',
  //   'https://images.unsplash.com/photo-1573554893531-5779992f6cd2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=465&q=80',
  //   'https://images.unsplash.com/photo-1578835187997-017d9952f020?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=435&q=80',
  // ];
  static final List<Product> productFeatured = [];

  Future getCategory() async {
    http.Response response = await http.get(Uri.parse(baseUrl + "categories"));

    // Check if the response is successful
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      // Add the titles and image links to the lists
      for (var item in data) {
        catalogueTitles.add(item['title']);
        catalogueImagesLink.add(baseUrl + item['image']);
      }
    } else {
      // Show an error message
      print("Something went wrong");
    }
  }

  Future getProductFeatured() async {
    http.Response response = await http.get(Uri.parse(baseUrl + "products/featured"));

    // Check if the response is successful
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      
      print(data);
      // Add the titles and image links to the lists
      for (var item in data) {
        productFeatured.add(Product(
            productId: item['productId'],
            name: item['name'],
            price: item['price'],
            image: item['image'],
            description: item['description'],
            cateId: item['cateId'],
            featured: item['featured']));
      }
    } else {
      // Show an error message
      print("Something went wrong");
    }
  }
}
