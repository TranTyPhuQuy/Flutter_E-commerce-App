import 'package:flutter/material.dart';
import 'package:smart_shop/Utils/app_colors.dart';
import 'package:smart_shop/Utils/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:smart_shop/utils/baseurl.dart';

class CartTile extends StatelessWidget {
  const CartTile({this.image, this.name,this.price, this.favoriteIcon, Key? key})
      : super(key: key);
  final String? image;
  final String? name;
  final String? price;
  final bool? favoriteIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 80,
          width: 80,
              decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: CachedNetworkImageProvider(baseUrl+image!),
              fit: BoxFit.cover,
            )),
        ),
        Expanded(
          child: Container(
            height: 80.h,
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name!,
                  style: FontStyles.montserratRegular14(),
                ),
                // SizedBox(height: 20.0),
                Text(price!,
                  style: FontStyles.montserratBold17(),
                )
              ],
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Icon(Icons.add_circle_outline, color: AppColors.lightGray),
            Text('1', style: TextStyle(color: AppColors.primaryLight)),
            Icon(
              Icons.remove_circle_outline,
              color: AppColors.lightGray,
            ),
          ],
        ),
      ],
    );
  }
}
