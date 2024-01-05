import 'package:flutter/material.dart';
import 'package:e_commerce_app/Utils/font_styles.dart';

class HomeItem extends StatefulWidget {
  const HomeItem({this.number, this.name, Key? key}) : super(key: key);
  final String? number;
  final String? name;

  @override
  State<HomeItem> createState() => _HomeItemState();
}

class _HomeItemState extends State<HomeItem> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildNumber(context, widget.number),
          _buildName(context, widget.name),
        ],
      ),
    );
  }

  Widget _buildNumber(BuildContext context, name) {
    var screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth * .40,
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
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

  Widget _buildName(BuildContext context, price) {
    var screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: screenWidth * .40,
      child: Text(
        price,
        style: FontStyles.montserratBold17(),
      ),
    );
  }
}
