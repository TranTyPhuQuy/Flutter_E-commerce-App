import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'sign_up_form.dart';

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
                Text("Đăng ký tài khoản", style: headingStyle),
                const Text(
                  "Hoàn thành thông tin đăng ký",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight! * 0.08),
                const SignUpForm(),
                SizedBox(height: SizeConfig.screenHeight! * 0.08),
                SizedBox(height: getProportionateScreenHeight(20)),
                Text(
                  'Bằng việc đăng kí, bạn đã đồng ý với chúng tôi \n về điều khoản và dịch vụ',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
