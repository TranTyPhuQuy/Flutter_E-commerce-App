import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/data/init_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_app/Common/Widgets/shimmer_effect.dart';
import 'package:e_commerce_app/Utils/app_colors.dart';
import 'package:e_commerce_app/Utils/font_styles.dart';
import 'package:e_commerce_app/utils/baseurl.dart';

class CatalogueWidget extends StatelessWidget {
  const CatalogueWidget({this.height, this.width, this.index, Key? key})
      : super(key: key);
  final double? height, width;
  final int? index;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5.0.w, top: 17.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: CachedNetworkImage(
              imageUrl: InitData.categories[index!].cateId == -1 ? 
              InitData.categories[index!].image.toString() :
              baseUrl+ InitData.categories[index!].image!,
              fit: BoxFit.cover,
              width: width,
              color: const Color.fromRGBO(29, 35, 50, 0.2),
              colorBlendMode: BlendMode.srcOver,
              height: height,
              placeholder: (context, error) {
                return ShimmerEffect(
                    borderRadius: 10.0, height: height, width: height);
              },
              errorWidget: (context, errorName, error) {
                return ShimmerEffect(
                    borderRadius: 10.0, height: height, width: width);
              },
            ),
          ),
          SizedBox(
            height: height,
            width: width,
            child: Center(
              child: Text(InitData.categories[index!].name!,
                style: FontStyles.montserratBold14().copyWith(
                  color: AppColors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
