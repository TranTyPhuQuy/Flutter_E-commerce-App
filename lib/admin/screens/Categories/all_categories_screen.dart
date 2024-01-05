import 'package:e_commerce_app/admin/Provider/categories_provider.dart';
import 'package:e_commerce_app/admin/common/Widgets/ad_item_widget.dart';
import 'package:e_commerce_app/admin/screens/Categories/add_category.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/Common/Widgets/custom_app_bar.dart';
import 'package:e_commerce_app/Screens/Notifications/notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ALLCategoriesScreen extends StatefulWidget {
  const ALLCategoriesScreen({Key? key}) : super(key: key);
  static const String routeName = 'ALLCategoriesScreen';

  @override
  State<ALLCategoriesScreen> createState() => _ALLCategoriesScreenState();
}

class _ALLCategoriesScreenState extends State<ALLCategoriesScreen> {
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
        backgroundColor: Color(0xFF4358DD),
        onPressed: () {
          // Thêm mã của bạn vào đây khi nút được nhấn!
          Navigator.pushNamed(context, AddCategoryScreen.routeName);
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
        title: 'Danh mục',
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
            SizedBox(child: Consumer<CategoriesAdmin>(
              builder: (context, value, child) {
                return GridView.builder(
                  shrinkWrap: true,
                  itemCount: value.getLstcategoryAdmin().length,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 270.0.h,
                      crossAxisSpacing: 10.0.w),
                  itemBuilder: (_, index) {
                    return ADItemWidget(
                      id: value.getLstcategoryAdmin()[index].cateId,
                      image: value.getLstcategoryAdmin()[index].image,
                      name: value.getLstcategoryAdmin()[index].name,
                      isCategory: true,
                    );
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
