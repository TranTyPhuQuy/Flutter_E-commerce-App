import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:e_commerce_app/components/custom_surfix_icon.dart';
import 'package:e_commerce_app/components/form_error.dart';
import 'package:e_commerce_app/helper/keyboard.dart';
import 'package:e_commerce_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:e_commerce_app/screens/login_success/login_success_screen.dart';
import 'package:http/http.dart' as http;
import 'package:e_commerce_app/utils/baseurl.dart';

import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  State<SignForm> createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  bool remember = false;
  final List<String> errors = [];

  void addError({String error=""}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String error=""}) {
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
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value!;
                  });
                },
              ),
              const Text("Remember me"),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: const Text(
                  "Quên mật khẩu",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Tiếp tục",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                KeyboardUtil.hideKeyboard(context);
                LoginUser();
              }
            },
          ),
        ],
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
        return;
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
        labelText: "Mật khẩu",
        hintText: "Nhập mật khẩu",floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value!)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Email",
        hintText: "Nhập địa chỉ email",
         floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
  // ignore: non_constant_identifier_names
  Future LoginUser() async {

    Map mapeddate = {
      'email': email,
      'password': password
    };

    print("JSON DATA: ${mapeddate}");

    http.Response response = await http.post(Uri.parse("${baseUrl}login"),body: mapeddate);


    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("DATA: ${data}");
      if (data['userId'] !='') {
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, LoginSuccessScreen.routeName);
      } else {
        // ignore: use_build_context_synchronously
        showSuccessDialog(context, 'Đăng nhập thất bại', 'Sai tài khoản hoặc mật khẩu');
        print("Invalid email or password");
      }
    } else {
        // ignore: use_build_context_synchronously
        showSuccessDialog(context, 'Đăng nhập thất bại', 'Lỗi kết nối với máy chủ');
      print("Something went wrong");
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
}
