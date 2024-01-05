import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/admin/Provider/products_provider.dart';
import 'package:e_commerce_app/admin/screens/Products/all_products_screen.dart';
import 'package:e_commerce_app/common/Widgets/shimmer_effect.dart';
import 'package:e_commerce_app/components/default_button.dart';
import 'package:e_commerce_app/components/form_error.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/helper/keyboard.dart';
import 'package:e_commerce_app/size_config.dart';
import 'package:e_commerce_app/utils/baseurl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({Key? key}) : super(key: key);
  static const String routeName = 'UpdateProductScreen';

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final _formKey = GlobalKey<FormState>();
  int _productId = 0;
  String _name = '';
  String _image = '';
  double _price = 0.0;
  String _description = '';
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

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    if (ModalRoute.of(context)!.settings.arguments != null) {
      Map<String, dynamic> args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      _productId = args['productId'];
      _name = args['name'];
      _image = args['image'];
      _price = args['price'];
      _description = args['description'];
      _quantity = args['quantity'];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cập nhật sản phẩm'),
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
                    buildProductIdFormField(),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    buildNameFormField(),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    buildPriceFormField(),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    buildDescFormField(),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    buildQuantityFormField(),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    FormError(errors: _errors),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    CachedNetworkImage(
                      imageUrl: baseUrl + _image,
                      fit: BoxFit.cover,
                      placeholder: (context, name) {
                        return ShimmerEffect(
                            borderRadius: 10.0,
                            height: screenHeight * .15,
                            width: screenWidth * .40);
                      },
                      errorWidget: (context, error, child) {
                        return ShimmerEffect(
                          borderRadius: 10.0,
                          height: screenHeight * .20,
                          width: screenWidth * .45,
                        );
                      },
                    ),
                    DefaultButton(
                      text: "Cập nhật",
                      press: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          KeyboardUtil.hideKeyboard(context);
                          Provider.of<ProductsAdmin>(context, listen: false)
                              .updateProduct(_productId, _name, _price, _description, _quantity)
                              .then((_) {
                            Navigator.pushNamed(
                                context, ALLProductsScreen.routeName);
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

  TextFormField buildProductIdFormField() {
    return TextFormField(
      initialValue: _productId.toString(),
      decoration: const InputDecoration(
        labelText: "Id",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      readOnly: true,
    );
  }
  TextFormField buildNameFormField() {
    return TextFormField(
      initialValue: _name,
      onSaved: (newValue) => _name = newValue!,
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
