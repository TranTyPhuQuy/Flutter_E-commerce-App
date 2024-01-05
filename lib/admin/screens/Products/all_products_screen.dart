import 'package:e_commerce_app/admin/Provider/products_provider.dart';
import 'package:e_commerce_app/admin/common/Widgets/ad_item_widget.dart';
import 'package:e_commerce_app/admin/screens/Products/add_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/Common/Widgets/custom_app_bar.dart';
import 'package:e_commerce_app/Screens/Notifications/notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ALLProductsScreen extends StatefulWidget {
  const ALLProductsScreen({Key? key}) : super(key: key);
  static const String routeName = 'ALLProductsScreen';

  @override
  State<ALLProductsScreen> createState() => _ALLProductsScreenState();
}

class _ALLProductsScreenState extends State<ALLProductsScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: _buildCustomAppBar(context),
      body: _buildBody(context),
      resizeToAvoidBottomInset: false,
            floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF4358DD),
        onPressed: () {
          // Thêm mã của bạn vào đây khi nút được nhấn!
          Navigator.pushNamed(context, AddProductScreen.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  PreferredSize _buildCustomAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize:
          Size(double.infinity, MediaQuery.of(context).size.height * .20),
      child: CustomAppBar(
        isHome: false,
        leadingIcon: Icons.arrow_back,
        leadingOnTap: () {
          Navigator.pop(context);
        },
        trailingIcon: Icons.notifications_none_outlined,
        trailingOnTap: () {
          Navigator.of(context).pushNamed(NotificationScreen.routeName);
        },
        title: 'Sản phẩm',
        scaffoldKey: _key,
        enableSearchField: true,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(
            left: 20.0.w,
            right: 20.0.w,
            top: 30.h,
            bottom: screenHeight * .09.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(child: Consumer<ProductsAdmin>(
              builder: (context, value, child) {
                return GridView.builder(
                  shrinkWrap: true,
                  itemCount: value.getAllProducts().length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 270.0.h,
                      crossAxisSpacing: 10.0.w),
                  itemBuilder: (_, index) {
                    return ADItemWidget(
                        id: value.getAllProducts()[index].productId,
                        image: value.getAllProducts()[index].image,
                        name: value.getAllProducts()[index].name,
                        price: value.getAllProducts()[index].price,
                        description: value.getAllProducts()[index].description,
                        quantity: value.getAllProducts()[index].quantity,
                        isCategory: false);
                  },
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
