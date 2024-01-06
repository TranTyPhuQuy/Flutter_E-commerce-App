import 'package:e_commerce_app/admin/screens/Categories/add_category.dart';
import 'package:e_commerce_app/admin/screens/Categories/all_categories_screen.dart';
import 'package:e_commerce_app/admin/screens/Products/add_product_screen.dart';
import 'package:e_commerce_app/admin/screens/Products/all_products_screen.dart';
import 'package:e_commerce_app/admin/screens/Categories/update_category_screen.dart';
import 'package:e_commerce_app/admin/screens/Products/update_product_screen.dart';
import 'package:e_commerce_app/admin/screens/dashboard_screen.dart';
import 'package:e_commerce_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:e_commerce_app/Screens/Cart/cart.dart';
import 'package:e_commerce_app/Screens/Catalogue/catalogue.dart';
import 'package:e_commerce_app/Screens/CheckOut/check_out.dart';
import 'package:e_commerce_app/Screens/Favorite/favorite.dart';
import 'package:e_commerce_app/Screens/Filter/filter.dart';
import 'package:e_commerce_app/Screens/Home/home.dart';
import 'package:e_commerce_app/Screens/Items/items.dart';
import 'package:e_commerce_app/Screens/Main/main.dart';
import 'package:e_commerce_app/Screens/Notifications/notifications.dart';
import 'package:e_commerce_app/Screens/Orders/order.dart';
import 'package:e_commerce_app/Screens/PrivacyPolicy/privacy_policy.dart';
import 'package:e_commerce_app/Screens/Profile/profile.dart';
import 'package:e_commerce_app/Screens/Settings/settings.dart';
import 'package:e_commerce_app/Screens/ShippingAddress/shipping_address.dart';
import 'package:e_commerce_app/screens/Product/product_screen.dart';
import 'package:e_commerce_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:e_commerce_app/screens/login_success/login_success_screen.dart';
import 'package:e_commerce_app/screens/sign_in/sign_in_screen.dart';
import 'package:e_commerce_app/screens/sign_up/sign_up_screen.dart';
import 'package:e_commerce_app/screens/splash/splash_screen.dart';

class AppConstants {
  static Map<String, Widget Function(dynamic)> appRoutes = {
    Home.routeName: (_) => const Home(),
    Main.routeName: (_) => const Main(),
    Catalogue.routeName: (_) => const Catalogue(),
    Items.routeName: (_) => const Items(),
    Filter.routeName: (_) => const Filter(),
    ProductScreen.routeName: (_) => ProductScreen(),
    Favorite.routeName: (_) => const Favorite(),
    Profile.routeName: (_) => const Profile(),
    Cart.routeName: (_) => const Cart(),
    CheckOut.routeName: (_) => const CheckOut(),
    Settings.routeName: (_) => const Settings(),
    Orders.routeName: (_) => const Orders(),
    PrivacyPolicy.routeName: (_) => const PrivacyPolicy(),
    NotificationScreen.routeName: (_) => const NotificationScreen(),
    ShippingAddress.routeName: (_) => const ShippingAddress(),
    SignInScreen.routeName: (_) => const SignInScreen(),
    SplashScreen.routeName: (_) => const SplashScreen(),
    ForgotPasswordScreen.routeName: (_) => const ForgotPasswordScreen(),
    LoginSuccessScreen.routeName: (_) => const LoginSuccessScreen(),
    SignUpScreen.routeName: (_) => const SignUpScreen(),
    AddCategoryScreen.routeName: (_) => const AddCategoryScreen(),
    DashBoardScreen.routeName: (_) => const DashBoardScreen(),
    ALLCategoriesScreen.routeName: (_) => const ALLCategoriesScreen(),
    ALLProductsScreen.routeName: (_) => const ALLProductsScreen(),
    UpdateCategoryScreen.routeName: (_) => const UpdateCategoryScreen(),
    UpdateProductScreen.routeName: (_) => const UpdateProductScreen(),
    AddProductScreen.routeName: (_) => const AddProductScreen(),
    CompleteProfileScreen.routeName:(_) => const CompleteProfileScreen()
  };

  static setSystemStyling() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light,
    );
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
  }

  static const privacyPolicyTxt =
      'Give your E-Commerce app an outstanding look.It\'s a small but attractive and beautiful design template for your E-Commerce App.Contact us for more amazing and outstanding designs for your apps.Do share this app with your Friends and rate us if you like this.Also check your other apps';
}
