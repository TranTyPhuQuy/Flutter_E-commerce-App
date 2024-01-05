import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/admin/Provider/categories_provider.dart';
import 'package:e_commerce_app/admin/screens/Categories/all_categories_screen.dart';
import 'package:e_commerce_app/common/Widgets/shimmer_effect.dart';
import 'package:e_commerce_app/components/default_button.dart';
import 'package:e_commerce_app/components/form_error.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/helper/keyboard.dart';
import 'package:e_commerce_app/size_config.dart';
import 'package:e_commerce_app/utils/baseurl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateCategoryScreen extends StatefulWidget {
  const UpdateCategoryScreen({Key? key}) : super(key: key);
  static const String routeName = 'UpdateCategoryScreen';

  @override
  State<UpdateCategoryScreen> createState() => _UpdateCategoryScreenState();
}

class _UpdateCategoryScreenState extends State<UpdateCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  // ignore: unused_field
  String _cateId = '';
  // ignore: unused_field
  String _name = '';
  String _image = '';
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
      _cateId = args['cateId'];
      _name = args['name'];
      _image = args['image'];
    }

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
                    buildCateIdFormField(),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    buildTitleFormField(),
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
                          Provider.of<CategoriesAdmin>(context, listen: false)
                              .updateCategory(_cateId, _name)
                              .then((_) {
                            Navigator.pushNamed(
                                context, ALLCategoriesScreen.routeName);
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

  TextFormField buildTitleFormField() {
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
        labelText: "Tên danh mục",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildCateIdFormField() {
    return TextFormField(
      initialValue: _cateId,
      decoration: const InputDecoration(
        labelText: "Id",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      readOnly: true,
    );
  }
}
