import 'package:e_commerce_app/screens/change%20_password/components/change_password_form.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

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
                SizedBox(height: SizeConfig.screenHeight! * 0.04), // 4%
                Text("Đổi mật khẩu", style: headingStyle),
                SizedBox(height: SizeConfig.screenHeight! * 0.08),
                const ChangePasswordForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
