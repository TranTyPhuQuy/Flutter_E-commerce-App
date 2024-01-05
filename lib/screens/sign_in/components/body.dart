import 'package:flutter/material.dart';
import 'package:e_commerce_app/components/no_account_text.dart';
import '../../../size_config.dart';
import 'sign_form.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight! * 0.04),
                Text(
                  "Chào mừng quay trở lại",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Đăng nhập với email và mật khẩu",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight! * 0.08),
                const SignForm(),
                SizedBox(height: SizeConfig.screenHeight! * 0.08),
                SizedBox(height: getProportionateScreenHeight(20)),
                const NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
