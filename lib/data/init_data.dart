import 'dart:convert';

import 'package:e_commerce_app/admin/Provider/categories_provider.dart';
import 'package:e_commerce_app/admin/Provider/products_provider.dart';
import 'package:e_commerce_app/models/categoryy.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/utils/baseurl.dart';
import 'package:http/http.dart' as http;

class InitData {
  static final List<String> sellerImagesLink = [
    'https://images.unsplash.com/photo-1558769132-cb1aea458c5e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80',
    'https://images.unsplash.com/photo-1603400521630-9f2de124b33b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
    'https://images.unsplash.com/photo-1445205170230-053b83016050?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=871&q=80',
    'https://images.unsplash.com/photo-1582719188393-bb71ca45dbb9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
  ];

  static final List<Categoryy> categories = [];
  static final List<Product> lstProductsFeatured = [];
  static final List<Product> lstProductsByCateId = [];
  // ignore: non_constant_identifier_names
  static final List<Product> LstProductRelated = [];

  static void initData() async {
    await getCategories();
    await getProductFeatured();
    await ProductsAdmin.fetchAllProduct();
  }

  static void sortLstProductsByCateId(String sortName) {
    if (sortName == 'Tên') {
      lstProductsByCateId.sort((a, b) => a.name.compareTo(b.name));
    } else if (sortName == 'Giá thấp') {
      lstProductsByCateId.sort((a, b) => a.price.compareTo(b.price));
    } else if (sortName == 'Giá cao') {
      lstProductsByCateId.sort((a, b) => b.price.compareTo(a.price));
    }
  }

  static Future getCategories() async {
    categories.clear();
    http.Response response =
        await http.get(Uri.parse("${baseUrl}categories/getCategoriesById"));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      for (var item in data) {
        categories.add(Categoryy(
            cateId: item['cateId'], name: item['name'], image: item['image']));
      }
    } else {
      // Show an error message
      print("Something went wrong");
    }
    CategoriesAdmin.addAlll(InitData.categories);
    categories.add(Categoryy(
        cateId: -1,
        name: 'All',
        image:
            'https://images.unsplash.com/photo-1557683304-673a23048d34?q=80&w=1700&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'));
  }

  static Future getProductFeatured() async {
    lstProductsFeatured.clear();
    http.Response response =
        await http.get(Uri.parse("${baseUrl}products/featured"));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var item in data) {
        lstProductsFeatured.add(Product(
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
      print("Something went wrong");
    }
  }

  static Future getLstProductRelated($cateId, $productId) async {
    LstProductRelated.clear();
    http.Response response = await http.get(
        Uri.parse("${baseUrl}products/getProductsByCateId?cateId=${$cateId}"));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var item in data) {
        if (item['productId'] != $productId) {
          LstProductRelated.add(Product(
              productId: item['productId'],
              name: item['name'],
              price: double.parse(item['price']),
              image: item['image'],
              description: item['description'],
              cateId: item['cateId'],
              featured: item['featured'],
              quantity: item['quantity']));
        }
      }
    } else {
      print("Something went wrong");
    }
  }

  static Future getProductsByCateId($cateId) async {
    lstProductsByCateId.clear();
    http.Response response;
    if ($cateId == -1) {
      response =
          await http.get(Uri.parse("${baseUrl}products/getProductsById"));
    } else {
      response = await http.get(Uri.parse(
          "${baseUrl}products/getProductsByCateId?cateId=${$cateId}"));
    }

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
        print('getProductsByCateId: cateId ='+$cateId.toString());
      for (var item in data) {
        print('productId =' + item['productId'].toString());
        lstProductsByCateId.add(Product(
            productId: item['productId'],
            name: item['name'],
            price: double.parse(item['price']),
            image: item['image'],
            description: item['description'],
            cateId: item['cateId'],
            featured: item['featured'],
            quantity: item['quantity']));
      }
      lstProductsByCateId.sort((a, b) => a.name.compareTo(b.name));
    } else {
      print("Something went wrong");
    }
  }
}
