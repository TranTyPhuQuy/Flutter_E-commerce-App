import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_app/Common/Widgets/shimmer_effect.dart';
import 'package:e_commerce_app/Utils/app_colors.dart';
import 'package:e_commerce_app/Utils/font_styles.dart';
import 'package:e_commerce_app/utils/baseurl.dart';

class ItemWidget extends StatefulWidget {
  const ItemWidget({this.image, this.name,this.price, this.favoriteIcon, Key? key})
      : super(key: key);
  final String? image;
  final String? name;
  final String? price;
  final bool? favoriteIcon;

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFeaturedWidget(context,widget.image),
        _buildFeaturedItemText(context,widget.name),
        _buildFeaturedItemPrice(context,widget.price),
      ],
    );
  }

  Widget _buildFeaturedWidget(BuildContext context, image) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                height: 163.h,
                width: 163.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: CachedNetworkImage(
                  imageUrl: baseUrl + image,
                  fit: BoxFit.cover,
                  placeholder: (context, name) {
                    return ShimmerEffect(
                        borderRadius: 10.0,
                        height: screenHeight * .15,
                        width: screenWidth * .40);
                  },
                  errorWidget: (context, error, child) {
                    return ShimmerEffect(
                      borderRadius: 10.0,
                      height: screenHeight * .20,
                      width: screenWidth * .45,
                    );
                  },
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              width: 47.0,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
                gradient: LinearGradient(
                  colors: [Color(0xFFF49763), Color(0xFFD23A3A)],
                  stops: [0, 1],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
              ),
              child: Center(
                child: Text(
                  '50%',
                  style: FontStyles.montserratBold17()
                      .copyWith(fontSize: 11.0, color: AppColors.white),
                ),
              ),
            ),
            widget.favoriteIcon!
                ? Positioned(
                    bottom: -15.0,
                    right: 10.0,
                    child: Container(
                        height: 36.0,
                        width: 36.0,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(36.0),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                          },
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color:
                                isFavorite ? AppColors.secondary : Colors.black,
                          ),
                        )),
                  )
                : const SizedBox(height: 0, width: 0),
          ],
        ),
        _buildRatings(context),
      ],
    );
  }

  Widget _buildRatings(BuildContext context) {
    return SizedBox(
      height: 20,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          itemCount: 5,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return const Icon(
              Icons.star,
              color: AppColors.secondary,
              size: 10.0,
            );
          }),
    );
  }

  Widget _buildFeaturedItemText(BuildContext context,name) {
    var screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth * .40,
      height: 50.0,
      child: SingleChildScrollView(
        child: Text(name,
          style: FontStyles.montserratRegular14().copyWith(
            color: const Color(0xFF34283E),
          ),
          overflow: TextOverflow.clip,
        ),
      ),
    );
  }

  Widget _buildFeaturedItemPrice(BuildContext context,price) {
    var screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth * .40,
      child: Text(price,
        style: FontStyles.montserratBold17(),
      ),
    );
  }
}
