import 'package:e_commerce_app/helper/format_price.dart';
import 'package:e_commerce_app/models/carrt.dart';
import 'package:e_commerce_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_app/Screens/Cart/cart.dart';
import 'package:e_commerce_app/Screens/Catalogue/catalogue.dart';
import 'package:e_commerce_app/Screens/Favorite/favorite.dart';
import 'package:e_commerce_app/Screens/Home/home.dart';
import 'package:e_commerce_app/Screens/Profile/profile.dart';
import 'package:e_commerce_app/Utils/app_colors.dart';
import 'package:e_commerce_app/Utils/font_styles.dart';

import '../../size_config.dart';

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);
  static const String routeName = 'main';

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int currentIndex = 0;
  List<Widget> myScreens = [
    const Home(),
    const Catalogue(),
    const Favorite(),
    const Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: myScreens.elementAt(currentIndex),
      bottomSheet: buildBottomSheet(),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget buildBottomSheet() {
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 50.0,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 1,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            currentIndex = 0;
                          });
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.home,
                              color: currentIndex == 0
                                  ? AppColors.primaryLight
                                  : Colors.grey,
                            ),
                            Text(
                              'Home',
                              style: TextStyle(
                                color: currentIndex == 0
                                    ? Colors.black
                                    : AppColors.textLightColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            currentIndex = 1;
                          });
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.category,
                              color: currentIndex == 1
                                  ? AppColors.primaryLight
                                  : Colors.grey,
                            ),
                            Text(
                              'Danh mục',
                              style: TextStyle(
                                color: currentIndex == 1
                                    ? Colors.black
                                    : AppColors.textLightColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            currentIndex = 2;
                          });
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.favorite_outline,
                              color: currentIndex == 2
                                  ? AppColors.primaryLight
                                  : Colors.grey,
                            ),
                            Text(
                              'Yêu thích',
                              style: TextStyle(
                                color: currentIndex == 2
                                    ? Colors.black
                                    : AppColors.textLightColor,
                              ),
                            )
                          ],
                        ),
                      ),
                      Consumer<AuthProvider>(
                        builder: (context, value, child) {
                          return value.getLogin()
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      currentIndex = 3;
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.person_outline,
                                        color: currentIndex == 3
                                            ? AppColors.primaryLight
                                            : Colors.grey,
                                      ),
                                      Text(
                                        'Profile',
                                        style: TextStyle(
                                          color: currentIndex == 3
                                              ? Colors.black
                                              : AppColors.textLightColor,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : Container(); // or replace with your placeholder widget
                        },
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: screenWidth * .3,
              ),
            ],
          ),
          Positioned(
              right: 0.0,
              bottom: 15.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Cart.routeName);
                },
                child: Container(
                    width: 116.0,
                    height: 56,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.primaryLight, AppColors.primaryDark],
                        end: Alignment.bottomLeft,
                        begin: Alignment.topRight,
                        stops: [0, 1],
                      ),
                      color: AppColors.primaryDark,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0),
                      ),
                    ),
                    child: ListTile(
                        contentPadding: const EdgeInsets.only(left: 10.0),
                        minLeadingWidth: 10.0,
                        leading: const Icon(
                          Icons.shopping_cart,
                          color: AppColors.white,
                          size: 21.0,
                        ),
                        title:
                            Consumer<Cartt>(builder: (context, value, child) {
                          return RichText(
                            text: TextSpan(
                              text:
                                  '${FormartPrice.getPriceVND(value.getTotalPrice())}\n',
                              style: FontStyles.montserratBold17().copyWith(
                                  fontSize: 11.0, color: AppColors.white),
                              children: [
                                TextSpan(
                                  text:
                                      '${value.getCounter().toString()} Sản phẩm',
                                  style: FontStyles.montserratRegular14()
                                      .copyWith(
                                          fontSize: 11.0,
                                          color: AppColors.white),
                                )
                              ],
                            ),
                          );
                        }))),
              )),
        ],
      ),
    );
  }
}
