import 'package:e_commerce_app/data/init_data.dart';
import 'package:e_commerce_app/screens/Main/main.dart';
import 'package:e_commerce_app/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../size_config.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "splash";
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
    @override
  void initState() {     
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, Main.routeName);
    });
  }
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    InitData.initData();
    SizeConfig().init(context);
    return Scaffold(
      body: Center(
          child: Image.asset(app_logo,
              width: context.width * 0.5,
              height: context.width * 0.5,
              fit: BoxFit.contain)),
    );
  }
}
