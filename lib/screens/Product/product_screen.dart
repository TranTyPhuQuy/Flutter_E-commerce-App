import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/common/Widgets/item_widget.dart';
import 'package:e_commerce_app/data/init_data.dart';
import 'package:e_commerce_app/models/carrt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_app/Common/Widgets/app_button.dart';
import 'package:e_commerce_app/Common/Widgets/shimmer_effect.dart';
import 'package:e_commerce_app/Utils/app_colors.dart';
import 'package:e_commerce_app/Utils/font_styles.dart';
import 'package:e_commerce_app/utils/baseurl.dart';
import 'package:e_commerce_app/models/product.dart';

// ignore: must_be_immutable
class ProductScreen extends StatelessWidget {
  static const String routeName = 'product_screen';
  ProductScreen({Key? key}) : super(key: key);
  late Product product;

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      product = ModalRoute.of(context)!.settings.arguments as Product;
    }
    return Scaffold(
      backgroundColor: AppColors.whiteLight,
      body: _buildBody(context),
      bottomSheet: _buildBottomSheet(
        context: context,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            collapsedHeight: kToolbarHeight,
            expandedHeight: screenHeight * .40.h,
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: baseUrl + product.image,
                // color: const Color.fromRGBO(42, 3, 75, 0.35),
                // colorBlendMode: BlendMode.srcOver,
                fit: BoxFit.cover,
                placeholder: (context, name) {
                  return ShimmerEffect(
                    borderRadius: 0.0.r,
                    height: screenHeight * .40.h,
                    width: screenWidth,
                  );
                },
                errorWidget: (context, error, child) {
                  return ShimmerEffect(
                    borderRadius: 0.0.r,
                    height: screenHeight * .40.h,
                    width: screenWidth,
                  );
                },
              ),
            ),
          ),
        ];
      },
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAboutProduct(context),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildProductDetail(context),
                  SizedBox(height: 10.0.h),
                  _buildRelatedProduct(context)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAboutProduct(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildRatings(context),
                Text(
                  'In Stock',
                  style: FontStyles.montserratBold12()
                      .copyWith(color: AppColors.green),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: Text(
              product.name,
              style: FontStyles.montserratRegular19(),
            ),
          ),
          _buildPrice(context, product.getPriceVND()),
        ],
      ),
    );
  }

  Widget _buildRatings(BuildContext context) {
    return SizedBox(
      height: 20.0.h,
      child: Row(
        children: [
          ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return const Icon(
                  Icons.star,
                  color: AppColors.secondary,
                  size: 14.0,
                );
              }),
          Text(
            ' 8 reviews',
            style: FontStyles.montserratRegular12(),
          ),
        ],
      ),
    );
  }


  Widget _buildPrice(BuildContext context, String price) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, top: 10.0.h),
      child: Text(
        price,
        style: FontStyles.montserratBold25(),
      ),
    );
  }
Widget _buildProductDetail(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(10.0.r),
    ),
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mô tả sản phẩm',
          style: FontStyles.montserratBold19(),
        ),
        SizedBox(height: 10.0.h),
        ExpansionTile(
          title: Text(
            'Xem thêm',
            style: FontStyles.montserratRegular14(),
          ),
          children: <Widget>[
            Text(
              product.description,
              style: FontStyles.montserratRegular14(),
            ),
          ],
        ),
      ],
    ),
  );
}


  Widget _buildRelatedProduct(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sản phẩm liên quan',
            style: FontStyles.montserratBold19()
                .copyWith(color: const Color(0xFF34283E)),
          ),
          SizedBox(height: 10.0.h),
          SizedBox(
            height: 310.h,
            // width: 200,
            child: ListView.builder(
                itemCount: InitData.LstProductRelated.length,
                itemExtent: 180.0.w,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ItemWidget(
                      image: InitData.LstProductRelated[index].image,
                      name: InitData.LstProductRelated[index].name,
                      price: InitData.LstProductRelated[index].getPriceVND(),
                      favoriteIcon: true,
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget _buildBottomSheet({BuildContext? context}) {
    return Container(
      width: double.infinity,
      height: 70.0.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0.r),
          topRight: Radius.circular(20.0.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.pop(context!);
              },
              child: const Icon(Icons.arrow_back)
              ),
          AppButton.button(
            text: 'Thêm vào giỏ hàng',
            color: AppColors.secondary,
            height: 48.0.h,
            width: 215.0.w,
            onTap: () {
              Provider.of<Cartt>(context!,listen: false).addProduct(product);
            },
          ),
          const Icon(Icons.favorite_border),
        ],
      ),
    );
  }
}
