import 'package:flutter/material.dart';
import 'package:e_commerce_app/screens/Main/main.dart';
import '../../../size_config.dart';
import '../components/splash_content.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {     
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, Main.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            const Expanded(
              flex: 3,
              child: SplashContent(
                image: "assets/images/splash_1.png",
                text: "Welcome to Tokoto, Let’s shop!",
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: const Column(
                  children: <Widget>[
                    Spacer(flex: 3),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
