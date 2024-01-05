import 'package:e_commerce_app/data/init_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_app/Common/Widgets/catalogue_widget.dart';
import 'package:e_commerce_app/Common/Widgets/item_widget.dart';
import 'package:e_commerce_app/Common/Widgets/custom_app_bar.dart';
import 'package:e_commerce_app/Screens/Filter/filter.dart';
import 'package:e_commerce_app/Utils/app_colors.dart';
import 'package:e_commerce_app/Utils/font_styles.dart';
import 'package:e_commerce_app/screens/Product/product_screen.dart';

class Catalogue extends StatefulWidget {
  static const String routeName = 'catalogue';

  const Catalogue({Key? key}) : super(key: key);
  @override
  State<Catalogue> createState() => _CatalogueState();
}

class _CatalogueState extends State<Catalogue> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  bool isItemClicked = false;
  bool seeAllClicked = false;
  bool showbackArrow = false;
  List<bool>? argList;
  late int cateId;
  bool renewed = false;
  String sortName = 'Tên';

  @override
  Widget build(BuildContext context) {
    if (!renewed && ModalRoute.of(context)!.settings.arguments != null) {
      Map<String, dynamic> args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      argList = args['lstBol'] as List<bool>;
      seeAllClicked = argList![0];
      showbackArrow = argList![1];
      isItemClicked = argList![2];
      cateId = args['cateId'];
      renewed = true;
    }

    return Scaffold(
      backgroundColor: AppColors.whiteLight,
      key: _key,
      appBar: _buildAppBar(context),
      body: isItemClicked ? _buildItemsBody(context) : _buildBody(context),
      resizeToAvoidBottomInset: false,
    );
  }

  PreferredSize _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize:
          Size(double.infinity, MediaQuery.of(context).size.height * .20),
      child: CustomAppBar(
          scaffoldKey: _key,
          isHome: false,
          enableSearchField: true,
          leadingIcon: showbackArrow
              ? (kIsWeb ? Icons.arrow_back : Icons.arrow_back_ios)
              : null,
          leadingOnTap: () {
            if (showbackArrow) {
              Navigator.pop(context);
            } else {
              setState(() {
                isItemClicked = false;
                if (seeAllClicked) {
                  Navigator.pop(context);
                }
              });
            }
          },
          trailingIcon: isItemClicked ? Icons.filter_1_outlined : null,
          trailingOnTap: isItemClicked
              ? () {
                  Navigator.pushNamed(context, Filter.routeName);
                }
              : () {},
          title: isItemClicked ? 'Clothing' : 'Danh mục'),
    );
  }

  Widget _buildBody(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(
          left: 10.0,
          right: 10.0,
          top: 20.0,
          bottom: seeAllClicked ? 0.0 : screenHeight * .10),
      child: ListView.builder(
        itemCount: InitData.categories.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return _buildCatalogueWidget(context, index: index);
        },
      ),
    );
  }

  Widget _buildCatalogueWidget(BuildContext context, {required int index}) {
    var screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () async {
        await InitData.getProductsByCateId(InitData.categories[index].cateId);
        setState(() {
          cateId = InitData.categories[index].cateId;
          isItemClicked = true;
        });
      },
      child: CatalogueWidget(
        height: 90.h,
        width: screenWidth,
        index: index,
      ),
    );
  }

  Widget _buildItemsBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20.0.w, top: 50.0.h),
            child: _buildCategoriesTags(context),
          ),
          _buildItemAndSortTile(context),
          _buildItems(context),
        ],
      ),
    );
  }

  Widget _buildCategoriesTags(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 32.0.h,
      child: ListView.builder(
        itemCount: InitData.categories.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () async {
                await InitData.getProductsByCateId(
                    InitData.categories[index].cateId);
                setState(() {
                  cateId = InitData.categories[index].cateId;
                });
              },
              child: Container(
                margin: EdgeInsets.only(right: 10.0.w),
                padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                decoration: BoxDecoration(
                    color: InitData.categories[index].cateId == cateId
                        ? AppColors.secondary
                        : AppColors.white,
                    borderRadius: BorderRadius.circular(25.0.r)),
                child: Center(
                  child: Text(
                    InitData.categories[index].name.toString(),
                    style: FontStyles.montserratRegular14().copyWith(
                        color: InitData.categories[index].cateId == cateId
                            ? AppColors.white
                            : AppColors.textLightColor),
                  ),
                ),
              ));
        },
      ),
    );
  }

  Widget _buildItemAndSortTile(BuildContext context) {
    return ListTile(
      title: Text(
        '${InitData.lstProductsByCateId.length} sản phẩm',
        style: FontStyles.montserratBold19(),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Sắp xếp: $sortName',
            style: FontStyles.montserratBold12()
                .copyWith(color: AppColors.textLightColor),
          ),
          PopupMenuButton<String>(
            onSelected: (String value) {
              // Handle your sorting logic here based on the selected value
              setState(() {
                sortName = value;
                InitData.sortLstProductsByCateId(sortName);
              });
            },
            itemBuilder: (BuildContext context) {
              return ['Tên', 'Giá thấp', 'Giá cao'].map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice,
                      style: FontStyles.montserratBold12()
                          .copyWith(color: AppColors.primaryDark)),
                );
              }).toList();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildItems(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(
          left: 15.0.w, right: 15.0.w, bottom: screenHeight * .08.h),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: InitData.lstProductsByCateId.length,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisExtent: 260.0.h, crossAxisSpacing: 10.0),
        itemBuilder: (_, index) {
          return GestureDetector(
            onTap: () async {
              await InitData.getLstProductRelated(
                  InitData.lstProductsByCateId[index].cateId,
                  InitData.lstProductsByCateId[index].productId);
              // ignore: use_build_context_synchronously
              Navigator.pushNamed(context, ProductScreen.routeName,
                  arguments: InitData.lstProductsByCateId[index]);
            },
            child: ItemWidget(
              image: InitData.lstProductsByCateId[index].image,
              name: InitData.lstProductsByCateId[index].name,
              price: InitData.lstProductsByCateId[index].getPriceVND(),
              favoriteIcon: true,
            ),
          );
        },
      ),
    );
  }
}
