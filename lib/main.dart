import 'package:e_commerce_app/admin/Provider/categories_provider.dart';
import 'package:e_commerce_app/admin/Provider/products_provider.dart';
import 'package:e_commerce_app/models/carrt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_app/Utils/Constants/app_constants.dart';
import 'package:e_commerce_app/Utils/app_theme.dart';
import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:e_commerce_app/screens/splash/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppConstants.setSystemStyling();
  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => CartProvider()),
          ChangeNotifierProvider(create: (ctx) => CategoriesAdmin()),
          ChangeNotifierProvider(create: (ctx) => ProductsAdmin()),
          ChangeNotifierProvider(create: (ctx) => Cartt())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          initialRoute: SplashScreen.routeName,
          routes: AppConstants.appRoutes,
        ),
      ),
    ),
  );
}
