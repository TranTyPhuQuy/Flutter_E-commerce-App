// ignore_for_file: avoid_web_libraries_in_flutter, use_build_context_synchronously
import 'dart:typed_data';
import 'dart:html' as html;
import 'dart:convert';
import 'package:e_commerce_app/admin/Provider/categories_provider.dart';
import 'package:e_commerce_app/admin/Provider/products_provider.dart';
import 'package:e_commerce_app/components/form_error.dart';
import 'package:e_commerce_app/helper/keyboard.dart';
import 'package:e_commerce_app/models/categoryy.dart';
import 'package:e_commerce_app/size_config.dart';

import 'package:flutter/material.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);
  static const String routeName = 'AddProductScreen';
  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  Uint8List? _bytesData;
  String _name = '';
  double _price = 0.0;
  String? _imageData;
  String _description = '';
  int? _cateId = CategoriesAdmin.categories.first.cateId;
  String? _cateName = CategoriesAdmin.categories.first.name;
  int _quantity = 0;
  final List<String> _errors = [];

  void addError({String error = ""}) {
    if (!_errors.contains(error)) {
      setState(() {
        _errors.add(error);
      });
    }
  }

  void removeError({String error = ""}) {
    if (_errors.contains(error)) {
      setState(() {
        _errors.remove(error);
      });
    }
  }

  void showSuccessDialog(BuildContext context, title, content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Đóng'))
          ],
        );
      },
    );
  }

  startWebFilePicker() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      final file = files![0];
      final reader = html.FileReader();

      reader.onLoadEnd.listen((event) {
        setState(() {
          _imageData = reader.result as String;
          _bytesData = const Base64Decoder()
              .convert(reader.result.toString().split(",").last);
          // Remove the part before the comma
          // print('imageData: ${imageData!}');
        });
      });
      reader.readAsDataUrl(file);
    });
  }

  @override
  Widget build(BuildContext context) {
    // var screenHeight = MediaQuery.of(context).size.height;
    // var screenWidth = MediaQuery.of(context).size.width;
    // _cateId = Provider.of<CategoriesAdmin>(context, listen: false)
    //     .getLstcategoryAdmin()
    //     .first
    //     .cateId;
    // _cateName = Provider.of<CategoriesAdmin>(context, listen: false)
    //     .getLstcategoryAdmin()
    //     .first
    //     .name;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cập nhật danh mục'),
        backgroundColor: const Color(0xfff4f3f4),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    buildNameFormField(),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    buildPriceFormField(),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    buildDescFormField(),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    buildQuantityFormField(),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    const Text('Chọn danh mục:'),
                    Consumer<CategoriesAdmin>(builder: (context, value, child) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black, // Màu đen
                            width: 2, // Độ dày 2
                          ),
                          borderRadius:
                              BorderRadius.circular(10), // Border radius 10
                        ),
                        child: DropdownButton<int>(
                          hint: Text(_cateName!),
                          isExpanded: true,
                          items: value
                              .getLstcategoryAdmin()
                              .map<DropdownMenuItem<int>>((Categoryy c) {
                            return DropdownMenuItem<int>(
                              value: c.cateId,
                              child: Text(c.name!),
                              onTap: () {
                                _cateId = c.cateId;
                                _cateName = c.name;
                                setState(() {
                                  
                                });
                              },
                            );
                          }).toList(),
                          onChanged: (int? newValue) {
                          },
                        ),
                      );
                    }),
                    FormError(errors: _errors),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    const Text('Let\'s upload Image'),
                    const SizedBox(height: 20),
                    MaterialButton(
                      color: Colors.pink,
                      elevation: 8,
                      highlightElevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      textColor: Colors.white,
                      child: const Text("Chọn ảnh"),
                      onPressed: () {
                        startWebFilePicker();
                      },
                    ),
                    const Divider(
                      color: Colors.teal,
                    ),
                    _bytesData != null
                        ? Image.memory(_bytesData!, width: 200, height: 200)
                        : Container(),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    MaterialButton(
                      color: Colors.purple,
                      elevation: 8,
                      highlightElevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      textColor: Colors.white,
                      child: const Text("Thêm"),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                        KeyboardUtil.hideKeyboard(context);
                        Provider.of<ProductsAdmin>(context, listen: false)
                            .addProduct(_name, _price, _description, _cateId!,
                                _quantity, _imageData!)
                            .then((_) {
                          showSuccessDialog(context, 'Đã thêm', 'Thành công');
                        }).onError((error, stackTrace) {
                          print(error);
                          showSuccessDialog(context, 'Đã thêm', 'Thất bại');
                        });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      onSaved: (newValue) => _name = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameCategoryNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNameCategoryNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Tên sản phẩm",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildPriceFormField() {
    return TextFormField(
      initialValue: _price.toString(),
      onSaved: (newValue) => _price = double.parse(newValue!),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Giá",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildDescFormField() {
    return TextFormField(
      initialValue: _description,
      onSaved: (newValue) => _description = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kDescriptionNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kDescriptionNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Mô tả",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildQuantityFormField() {
    return TextFormField(
      initialValue: _quantity.toString(),
      onSaved: (newValue) => _quantity = int.parse(newValue!),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Số lượng",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
