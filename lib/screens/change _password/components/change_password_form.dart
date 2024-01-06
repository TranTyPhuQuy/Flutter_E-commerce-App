import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:e_commerce_app/components/custom_surfix_icon.dart';
import 'package:e_commerce_app/components/default_button.dart';
import 'package:e_commerce_app/components/form_error.dart';
import 'package:http/http.dart' as http;
import 'package:e_commerce_app/screens/sign_in/sign_in_screen.dart';
import 'package:e_commerce_app/utils/baseurl.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({Key? key}) : super(key: key);

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  // ignore: non_constant_identifier_names
  late String conform_password;

  bool remember = false;
  final List<String> errors = [];

  void addError({String error = ""}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String error = ""}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildOldPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConformPassFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Tiếp tục",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                RegistrationUser();
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => conform_password = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == conform_password) {
          removeError(error: kMatchPassError);
        }
        conform_password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Confirm Password",
        hintText: "Nhập lại mật khẩu",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Password",
        hintText: "Nhập mật khẩu mới",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildOldPasswordFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue!,
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
        labelText: "Mật khẩu cũ",
        hintText: "Nhập mật khẩu cũ",floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Future RegistrationUser() async {
    Map mapeddate = {'email': email, 'password': password};

    print("JSON DATA: ${mapeddate}");

    http.Response response =
        await http.post(Uri.parse("${baseUrl}users"), body: mapeddate);

    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (data['success']) {
        // ignore: use_build_context_synchronously
        showSuccessDialog(context, 'Đăng ký', 'Thành công', true);
      } else {
        // ignore: use_build_context_synchronously
        showSuccessDialog(
            context, 'Đăng ký', 'Thất bại! Email đã tồn tại', false);
      }
      print("DATA: ${data}");
    } else {
      // ignore: use_build_context_synchronously
      showSuccessDialog(
          context, 'Đăng nhập thất bại', 'Lỗi kết nối với máy chủ', true);
    }
  }

  void showSuccessDialog(BuildContext context, title, content, success) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () {
                  if (success) {
                    Navigator.pushNamed(context, SignInScreen.routeName);
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Đóng'))
          ],
        );
      },
    );
  }
}
