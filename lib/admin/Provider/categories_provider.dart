import 'dart:convert';

import 'package:e_commerce_app/models/categoryy.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/utils/baseurl.dart';
import 'package:http/http.dart' as http;

class CategoriesAdmin extends ChangeNotifier {
  static final List<Categoryy> categories = [];

  List<Categoryy> getLstcategoryAdmin() {
    return categories;
  }

  void _deleteCategory(int cateId) {
    categories.removeWhere((c) => c.cateId == cateId);
    notifyListeners();
  }

  static void addAlll(List<Categoryy> lst) {
    categories.clear();
    categories.addAll(lst);
  }

  void _updateCate(int cateId, String name) {
    for (var c in categories) {
      if (c.cateId == cateId) {
        c.name = name;
      }
    }

    notifyListeners();
  }

  void _addCate(int cateId, String name, String image) {
    categories.add(Categoryy(cateId: cateId, name: name, image: image));
    notifyListeners();
  }

  Future updateCategory(String cateId, String name) async {
      Map map = {'cateId': cateId, 'name': name};
      http.Response response = await http
          .post(Uri.parse("${baseUrl}categories/updatecategory"), body: map);

      // Check if the response is successful
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['success']) {
          _updateCate(int.parse(cateId), name);
        }
      } else {
        // Show an error message
        print("Something went wrong");
      }
  }

  Future deleteCateByCateId(int cateId) async {
    http.Response response = await http.delete(Uri.parse(
        "${baseUrl}categories/deleteCategoryByCateId?cateId=$cateId"));

    // Check if the response is successful
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['success']) {
        _deleteCategory(cateId);
      }
    } else {
      // Show an error message
      print("Something went wrong");
    }
  }

  Future addCategory(String name, String imageData) async {
      print("name addCategory: ${name}");
    Map mapeddate = {
      'name': name,
      'imageData': imageData,
    };
    http.Response response =
        await http.post(Uri.parse('${baseUrl}categories/addCategory'), body: mapeddate);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("DATA: ${data}");
      if (data['success']) {
        _addCate(int.parse(data['cateId']), data['name'], data['image']);
        print("upload suscess");
      }
    }else {
      // Show an error message
      print("Something went wrong");
    }
  }
}
