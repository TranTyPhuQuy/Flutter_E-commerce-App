import 'package:e_commerce_app/admin/screens/Categories/all_categories_screen.dart';
import 'package:e_commerce_app/admin/screens/Products/all_products_screen.dart';
import 'package:e_commerce_app/admin/screens/home_fragment.dart';
import 'package:e_commerce_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/Screens/Profile/profile.dart';
import 'package:e_commerce_app/Utils/app_colors.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);
  static const String routeName = 'DashBoardScreen';
  
  @override
  State<DashBoardScreen> createState() => _DashBoardScreen();
}

class _DashBoardScreen extends State<DashBoardScreen> {
  int currentIndex = 0;
  List<Widget> myScreens = [
    const HomeFragment(),
    const ALLCategoriesScreen(),
    const ALLProductsScreen(),
    const Profile(),
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
                              Icons.app_registration_outlined,
                              color: currentIndex == 2
                                  ? AppColors.primaryLight
                                  : Colors.grey,
                            ),
                            Text(
                              'Sản phẩm',
                              style: TextStyle(
                                color: currentIndex == 2
                                    ? Colors.black
                                    : AppColors.textLightColor,
                              ),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
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
                              'Users',
                              style: TextStyle(
                                color: currentIndex == 3
                                    ? Colors.black
                                    : AppColors.textLightColor,
                              ),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            currentIndex = 4;
                          });
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.pending_actions_outlined,
                              color: currentIndex == 4
                                  ? AppColors.primaryLight
                                  : Colors.grey,
                            ),
                            Text(
                              'Oders',
                              style: TextStyle(
                                color: currentIndex == 4
                                    ? Colors.black
                                    : AppColors.textLightColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
