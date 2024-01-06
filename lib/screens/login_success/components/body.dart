import 'package:flutter/material.dart';
import 'package:e_commerce_app/components/default_button.dart';
import 'package:e_commerce_app/screens/Main/main.dart';

import '../../../size_config.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight! * 0.04),
        Image.asset(
          "assets/images/success.png",
          height: SizeConfig.screenHeight! * 0.4, //40%
        ),
        SizedBox(height: SizeConfig.screenHeight! * 0.08),
        Text(
          "Đăng nhập thành công",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(30),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth! * 0.6,
          child: DefaultButton(
            text: "Trang chủ",
            press: () {
              Navigator.pushNamed(context, Main.routeName);
            },
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
