import 'package:e_commerce_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_app/Utils/app_colors.dart';
import 'package:e_commerce_app/Utils/font_styles.dart';
import 'package:provider/provider.dart';

class AppHeaderGradient extends StatelessWidget {
  const AppHeaderGradient(
      {this.text, this.isProfile, this.fixedHeight, Key? key})
      : super(key: key);
  final String? text;
  final bool? isProfile;
  final double? fixedHeight;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: fixedHeight ?? 220.h,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [AppColors.primaryLight, AppColors.primaryDark],
                stops: [0, 1],
                end: Alignment.topRight,
                begin: Alignment.bottomLeft),
            color: AppColors.primaryDark,
            borderRadius: BorderRadius.only(
              bottomRight: isProfile!
                  ? Radius.circular(150.0.r)
                  : Radius.circular(250.0.r),
            ),
          ),
          child: isProfile!
              ? _buildProfileInfo(context)
              : Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 24.w, right: 34.w),
                    child: Text(
                      text!,
                      style: FontStyles.montserratBold25()
                          .copyWith(color: AppColors.white),
                    ),
                  ),
                ),
        ),
        Positioned(
          top: 40.0.h,
          left: 10.0.w,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }

  
  Widget _buildProfileInfo(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.0.w, top: 40.0.h),
      child: Consumer<AuthProvider>(builder: (context, value, child) {
        return  Row(
        children: [
          CircleAvatar(
            radius: 40.0.r,
            backgroundImage: const AssetImage('assets/images/user.png'),
          ),
          SizedBox(width: 10.0.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value.getUser().userName,
                style: FontStyles.montserratBold19()
                    .copyWith(color: AppColors.white),
              ),
              Text(value.getUser().email,
                style: FontStyles.montserratRegular14()
                    .copyWith(color: AppColors.white),
              ),
            ],
          ),
        ],
      );
      }),
    );
  }
}
