import 'package:e_commerce_app/helper/format_price.dart';
import 'package:e_commerce_app/models/carrt.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/Utils/app_colors.dart';
import 'package:e_commerce_app/Utils/font_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/utils/baseurl.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CartTile extends StatefulWidget {
  CartTile(
      {required this.product,
      required this.quantity,
      this.favoriteIcon,
      Key? key})
      : super(key: key);
  final Product product;
  int quantity;
  final bool? favoriteIcon;

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  int _quantity = 1;
  @override
  void initState() {
    super.initState();
    _quantity = widget.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image:
                    CachedNetworkImageProvider(baseUrl + widget.product.image),
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
                Text(
                  widget.product.name,
                  style: FontStyles.montserratRegular14(),
                ),
                Text(
                  FormartPrice.getPriceVND(widget.product.price),
                  style: FontStyles.montserratBold17(),
                )
              ],
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                _quantity++;
                Provider.of<Cartt>(context, listen: false)
                    .addProduct(widget.product);
                setState(() {});
              },
              child: const Icon(Icons.add_circle_outline,
                  color: AppColors.lightGray),
            ),
            Text(_quantity.toString(),
                style: const TextStyle(color: AppColors.primaryLight)),
            GestureDetector(
              onTap: () {
                if (_quantity > 1) {
                  setState(() {
                    _quantity--;
                    Provider.of<Cartt>(context, listen: false)
                        .removeProduct(widget.product);
                  });
                }
              },
              child: const Icon(Icons.remove_circle_outline,
                  color: AppColors.lightGray),
            ),
          ],
        ),
      ],
    );
  }
}
