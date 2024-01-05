import 'package:e_commerce_app/Common/Widgets/custom_app_bar.dart';
import 'package:e_commerce_app/Screens/Notifications/notifications.dart';
import 'package:e_commerce_app/admin/Provider/categories_provider.dart';
import 'package:e_commerce_app/admin/Provider/products_provider.dart';
import 'package:e_commerce_app/admin/screens/Categories/all_categories_screen.dart';
import 'package:e_commerce_app/admin/screens/Products/all_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({Key? key}) : super(key: key);
  static const String routeName = 'HomeFragment';

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
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
    );
  }

  PreferredSize _buildCustomAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize:
          Size(double.infinity, MediaQuery.of(context).size.height * .20),
      child: CustomAppBar(
        isHome: true,
        enableSearchField: false,
        trailingIcon: Icons.notifications_none_outlined,
        trailingOnTap: () {
          Navigator.of(context).pushNamed(NotificationScreen.routeName);
        },
        scaffoldKey: _key,
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    // return SingleChildScrollView(
    // child:
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            Consumer<CategoriesAdmin>(
              builder: (context, value, child) {
                return createCard(
                    '${value.getLstcategoryAdmin().length} Danh mục',
                    ALLCategoriesScreen.routeName);
              },
            ),
            Consumer<ProductsAdmin>(
              builder: (context, value, child) {
                return createCard('${value.getAllProducts().length} Sản phẩm',
                    ALLProductsScreen.routeName);
              },
            ),
            createCard('55 ' + ' Users', ''),
            createCard('2 ' + 'Orders', ''),
          ],
        ),
      ),
    );
    // );
  }

  Card createCard(String title, String pushName) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, pushName);
        },
        child: Center(
          child: Text(
            title,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
