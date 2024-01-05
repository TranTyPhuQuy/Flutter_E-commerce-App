import 'package:e_commerce_app/common/Widgets/cart_tile.dart';
import 'package:e_commerce_app/helper/format_price.dart';
import 'package:e_commerce_app/models/carrt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_app/Common/Widgets/app_button.dart';
import 'package:e_commerce_app/Common/Widgets/custom_app_bar.dart';
import 'package:e_commerce_app/Screens/CheckOut/check_out.dart';
import 'package:e_commerce_app/Utils/app_colors.dart';
import 'package:e_commerce_app/Utils/font_styles.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  static const String routeName = 'cart';
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteLight,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      bottomSheet: _buildBottomSheet(context),
    );
  }

  PreferredSize _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize:
          Size(double.infinity, MediaQuery.of(context).size.height * .20.h),
      child: CustomAppBar(
        isHome: false,
        title: 'Giỏ hàng',
        fixedHeight: 88.0.h,
        enableSearchField: false,
        leadingIcon: kIsWeb ? Icons.arrow_back : Icons.arrow_back_ios,
        leadingOnTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
        color: AppColors.white,
        child: Consumer<Cartt>(
          builder: (context, value, child) {
            return ListView.separated(
              itemCount: value.getCarts().length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  color: AppColors.white,
                  margin: EdgeInsets.symmetric(
                      horizontal: 20.0.w, vertical: 10.0.h),
                  child: CartTile(
                      product: value.getCarts()[index].getProduct(),
                      quantity: value.getCarts()[index].getQuantity(),
                      favoriteIcon: true),
                      
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            );
          },
        ));
  }

  Widget _buildBottomSheet(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0.r),
          topRight: Radius.circular(20.0.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tổng tiền', style: FontStyles.montserratBold19()),
                Consumer<Cartt>(builder: (context, value, child) {
                  return Text(FormartPrice.getPriceVND(value.getTotalPrice()), style: FontStyles.montserratBold19());
                })
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10.0.h),
            child: AppButton.button(
              text: 'Thanh toán',
              color: AppColors.secondary,
              height: 48.h,
              width: size.width - 20.w,
              onTap: () {
                Navigator.pushNamed(context, CheckOut.routeName);
              },
            ),
          ),
        ],
      ),
    );
  }
}
