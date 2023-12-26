import 'package:flutter/material.dart';
import 'components/body.dart';
import '../../size_config.dart';
import 'package:smart_shop/dummy/dummy_data.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";

  const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    DummyData().getCategory();
    DummyData().getProductFeatured();
    SizeConfig().init(context);
    return const Scaffold(
      body: Body(),
    );
  }
}
