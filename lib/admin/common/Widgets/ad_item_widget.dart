import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/admin/Provider/categories_provider.dart';
import 'package:e_commerce_app/admin/Provider/products_provider.dart';
import 'package:e_commerce_app/admin/screens/Categories/update_category_screen.dart';
import 'package:e_commerce_app/admin/screens/Products/update_product_screen.dart';
import 'package:e_commerce_app/helper/format_price.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_app/Common/Widgets/shimmer_effect.dart';
import 'package:e_commerce_app/Utils/font_styles.dart';
import 'package:e_commerce_app/utils/baseurl.dart';
import 'package:provider/provider.dart';

class ADItemWidget extends StatefulWidget {
  const ADItemWidget(
      {this.id, this.image, this.name, this.price, this.description, this.quantity, this.isCategory, Key? key})
      : super(key: key);
  final int? id;
  final String? image;
  final String? name;
  final double? price;
  final bool? isCategory;
  final String? description;
  final int? quantity;
  @override
  State<ADItemWidget> createState() => _ADItemWidget();
}

class _ADItemWidget extends State<ADItemWidget> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildWidget(context, widget.image),
        _buildItemText(context, widget.name),
        if (!widget.isCategory!) _buildFeaturedItemPrice(context, widget.price),
        _buildHandle(context, widget.id, widget.name, widget.image,
            widget.price,widget.description,widget.quantity, widget.isCategory),
      ],
    );
  }

  Widget _buildWidget(BuildContext context, image) {
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
          ],
        ),
      ],
    );
  }

  Widget _buildItemText(BuildContext context, name) {
    var screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth * .40,
      height: 50.0,
      child: SingleChildScrollView(
        child: Text(
          name,
          style: FontStyles.montserratRegular14().copyWith(
            color: const Color(0xFF34283E),
          ),
          overflow: TextOverflow.clip,
        ),
      ),
    );
  }

  Widget _buildHandle(
      BuildContext context, id, name, image, price,description, quantity, isCategory) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              isCategory == true
                  ? Navigator.pushNamed(context, UpdateCategoryScreen.routeName,
                      arguments: {
                          'cateId': id.toString(),
                          'name': name,
                          'image': image
                        })
                  : Navigator.pushNamed(context, UpdateProductScreen.routeName,
                      arguments: {
                          'productId': id,
                          'name': name,
                          'image': image,
                          'price': price as double,
                          'description' : description,
                          'quantity' :quantity as int
                        });
            },
            icon: const Icon(
              Icons.border_color_rounded,
              color: Colors.lightBlue,
            )),
        IconButton(
          onPressed: () async {
            final shouldDelete = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Xác nhận'),
                  content: const Text('Bạn có chắc chắn muốn xóa không?'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Hủy'),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                    TextButton(
                      child: const Text('Xóa'),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ],
                );
              },
            );
            if (shouldDelete) {
              if (isCategory) {
                // ignore: use_build_context_synchronously
                Provider.of<CategoriesAdmin>(context, listen: false)
                    .deleteCateByCateId(id);
              } else {
                // ignore: use_build_context_synchronously
                Provider.of<ProductsAdmin>(context, listen: false)
                    .deleteProductByProductId(id);
              }
            }
          },
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        )
      ],
    );
  }

  Widget _buildFeaturedItemPrice(BuildContext context, price) {
    var screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth * .40,
      child: Text(
        FormartPrice.getPriceVND(price),
        style: FontStyles.montserratBold17(),
      ),
    );
  }
}
