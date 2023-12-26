import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_shop/Screens/Cart/cart.dart';
import 'package:smart_shop/Screens/Catalogue/catalogue.dart';
import 'package:smart_shop/Screens/CheckOut/check_out.dart';
import 'package:smart_shop/Screens/Favorite/favorite.dart';
import 'package:smart_shop/Screens/Filter/filter.dart';
import 'package:smart_shop/Screens/Home/home.dart';
import 'package:smart_shop/Screens/Items/items.dart';
import 'package:smart_shop/Screens/Login/phone_screen.dart';
import 'package:smart_shop/Screens/Login/verification_screen.dart';
import 'package:smart_shop/Screens/Main/main.dart';
import 'package:smart_shop/Screens/Notifications/notifications.dart';
import 'package:smart_shop/Screens/Onboarding/onboarding.dart';
import 'package:smart_shop/Screens/Orders/order.dart';
import 'package:smart_shop/Screens/PrivacyPolicy/privacy_policy.dart';
import 'package:smart_shop/Screens/Profile/profile.dart';
import 'package:smart_shop/Screens/Settings/settings.dart';
import 'package:smart_shop/Screens/ShippingAddress/shipping_address.dart';
import 'package:smart_shop/Screens/SignUp/sign_up.dart';
import 'package:smart_shop/admin/screens/AdminCategory/add_category.dart';
import 'package:smart_shop/screens/Product/product_screen.dart';
import 'package:smart_shop/screens/forgot_password/forgot_password_screen.dart';
import 'package:smart_shop/screens/login_success/login_success_screen.dart';
import 'package:smart_shop/screens/sign_in/sign_in_screen.dart';
import 'package:smart_shop/screens/sign_up/sign_up_screen.dart';
import 'package:smart_shop/screens/splash/splash_screen.dart';

class AppConstants {
  static Map<String, Widget Function(dynamic)> appRoutes = {
    '/': (_) => const OnBoarding(),
    Login.routeName: (_) => const Login(),
    Verification.routeName: (_) => const Verification(),
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
    SignUp.routeName: (_) => const SignUp(),
    Settings.routeName: (_) => const Settings(),
    Orders.routeName: (_) => const Orders(),
    PrivacyPolicy.routeName: (_) => const PrivacyPolicy(),
    OnBoarding.routeName: (_) => const OnBoarding(),
    NotificationScreen.routeName: (_) => const NotificationScreen(),
    ShippingAddress.routeName: (_) => const ShippingAddress(),
    SignInScreen.routeName: (_) => const SignInScreen(),
    SplashScreen.routeName: (_) => const SplashScreen(),
    ForgotPasswordScreen.routeName: (_) => const ForgotPasswordScreen(),
    LoginSuccessScreen.routeName: (_) => const LoginSuccessScreen(),
    SignUpScreen.routeName: (_) => const SignUpScreen(),
    AddCategoryScreen.routeName: (_) => const AddCategoryScreen()
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
