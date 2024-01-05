import 'package:e_commerce_app/admin/screens/dashboard_screen.dart';
import 'package:e_commerce_app/data/init_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/Common/Widgets/app_title.dart';
import 'package:e_commerce_app/Common/Widgets/catalogue_widget.dart';
import 'package:e_commerce_app/Common/Widgets/custom_app_bar.dart';
import 'package:e_commerce_app/Common/Widgets/item_widget.dart';
import 'package:e_commerce_app/Screens/Catalogue/catalogue.dart';
import 'package:e_commerce_app/Screens/Notifications/notifications.dart';
import 'package:e_commerce_app/screens/Product/product_screen.dart';
import 'package:e_commerce_app/Screens/Settings/settings.dart';
import 'package:e_commerce_app/Utils/app_colors.dart';
import 'package:e_commerce_app/Utils/font_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/Common/Widgets/shimmer_effect.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_app/screens/sign_in/sign_in_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static const String routeName = 'home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: _buildCustomAppBar(context),
      drawer: _buildDrawer(context),
      body: _buildBody(context),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSellerCard(),
          _buildCatalogue(),
          _buildFeatured(context),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .60,
      child: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .20,
              child: DrawerHeader(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primaryDark, AppColors.primaryLight],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    stops: [0, 1],
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(left: 20.0),
                    child: AppTitle(
                      fontStyle: FontStyles.montserratExtraBold18(),
                      marginTop: 0.0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 3.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, Settings.routeName);
                    },
                    leading: const Icon(Icons.settings,
                        color: AppColors.primaryLight),
                    title: Text(
                      'Cài đặt',
                      style: FontStyles.montserratRegular18(),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, DashBoardScreen.routeName);
                    },
                    leading: const Icon(Icons.help_outline,
                        color: AppColors.primaryLight),
                    title: Text(
                      'Help',
                      style: FontStyles.montserratRegular18(),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, SignInScreen.routeName);
                    },
                    leading: const Icon(Icons.login_outlined,
                        color: AppColors.primaryLight),
                    title: Text(
                      'Đăng nhập',
                      style: FontStyles.montserratRegular18(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSize _buildCustomAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize:
          Size(double.infinity, MediaQuery.of(context).size.height * .20),
      child: CustomAppBar(
        isHome: true,
        enableSearchField: true,
        leadingIcon: Icons.menu,
        leadingOnTap: () {},
        trailingIcon: Icons.notifications_none_outlined,
        trailingOnTap: () {
          Navigator.of(context).pushNamed(NotificationScreen.routeName);
        },
        scaffoldKey: _key,
      ),
    );
  }

  Widget _buildSellerCard() {
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(left: 20.0.w, right: 20.w, top: 50.0.h),
      height: 88.h,
      width: 343.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0.r),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0.r),
            child: makeSlider(),
          ),
          Positioned(
              top: screenHeight * .020.h,
              left: 20.0,
              child: Text(
                'Sale',
                style: FontStyles.montserratBold25()
                    .copyWith(color: AppColors.white),
              )),
          Positioned(
            top: screenHeight * .070.h,
            left: 20.0.w,
            child: Row(
              children: [
                Text(
                  'Xêm thêm',
                  style: FontStyles.montserratBold12().copyWith(
                    color: AppColors.secondary,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 12.0.h,
                  color: AppColors.secondary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCatalogue() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Catalogue.routeName,
            arguments: [false, true, true]);
      },
      child: Container(
        margin: EdgeInsets.only(
            top: 25.0.h, left: 20.h, right: 20.0.h, bottom: 17.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Danh mục',
                  style: FontStyles.montserratBold19().copyWith(
                    color: const Color(0xFF34283E),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Catalogue.routeName,
                        arguments: [false, false]);
                  },
                  child: Text(
                    'Tất cả',
                    style: FontStyles.montserratBold12()
                        .copyWith(color: const Color(0xFF9B9B9B)),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 97.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: InitData.categories.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () async {
                        await InitData.getProductsByCateId(
                            InitData.categories[index].cateId);
                        // ignore: use_build_context_synchronously
                        Navigator.pushNamed(context, Catalogue.routeName,
                            arguments: {
                              'lstBol': [false, true, true],
                              'cateId': InitData.categories[index].cateId
                            });
                      },
                      child: CatalogueWidget(
                        height: 88.h,
                        width: 88.w,
                        index: index,
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatured(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(
          left: 20.0.w, right: 20.0.w, top: 20.h, bottom: screenHeight * .09.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Featured',
            style: FontStyles.montserratBold19()
                .copyWith(color: const Color(0xFF34283E)),
          ),
          SizedBox(height: 10.0.h),
          SizedBox(
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: InitData.lstProductsFeatured.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 270.0.h,
                  crossAxisSpacing: 10.0.w),
              itemBuilder: (_, index) {
                return GestureDetector(
                    onTap: () async {
                      await InitData.getLstProductRelated(
                          InitData.lstProductsFeatured[index].cateId,InitData.lstProductsFeatured[index].productId);
                      // ignore: use_build_context_synchronously
                      Navigator.pushNamed(context, ProductScreen.routeName,
                          arguments: InitData.lstProductsFeatured[index]);
                    },
                    child: ItemWidget(
                      image: InitData.lstProductsFeatured[index].image,
                      name: InitData.lstProductsFeatured[index].name,
                      price: InitData.lstProductsFeatured[index].getPriceVND(),
                      favoriteIcon: true,
                    ));
              },
            ),
          ),
        ],
      ),
    );
    // const SizedBox(height: 20.0),
  }

  Widget makeSlider() {
    return CarouselSlider.builder(
        unlimitedMode: true,
        autoSliderDelay: const Duration(seconds: 5),
        enableAutoSlider: true,
        slideBuilder: (index) {
          return CachedNetworkImage(
            imageUrl: InitData.sellerImagesLink[index],
            color: const Color.fromRGBO(42, 3, 75, 0.35),
            colorBlendMode: BlendMode.srcOver,
            fit: BoxFit.fill,
            placeholder: (context, name) {
              return ShimmerEffect(
                borderRadius: 10.0.r,
                height: 88.h,
                width: 343.w,
              );
            },
            errorWidget: (context, error, child) {
              return ShimmerEffect(
                borderRadius: 10.0.r,
                height: 88.h,
                width: 343.w,
              );
            },
          );
        },
        slideTransform: const DefaultTransform(),
        slideIndicator: CircularSlideIndicator(
          currentIndicatorColor: AppColors.lightGray,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 10.h, left: 20.0.w),
        ),
        itemCount: InitData.sellerImagesLink.length);
  }
}
