import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/screens/account/components/edit_email.dart';
import 'package:fyp_mobile_app/screens/account/components/edit_name.dart';
import 'package:fyp_mobile_app/screens/account/components/edit_password.dart';
import 'package:fyp_mobile_app/screens/account/components/personal_details.dart';
import 'package:fyp_mobile_app/screens/login/components/reset_password_page.dart';
import 'package:fyp_mobile_app/screens/orders/orders.dart';
import 'package:fyp_mobile_app/screens/components/bottom_bar.dart';
import 'package:fyp_mobile_app/screens/dashboard/components/category_screen.dart';
import 'package:fyp_mobile_app/screens/dashboard/dashboard.dart';
import 'package:fyp_mobile_app/screens/login/login_screen.dart';
import 'package:fyp_mobile_app/screens/registration/components/verify_otp.dart';
import 'package:fyp_mobile_app/screens/registration/registration_screen.dart';
import 'package:fyp_mobile_app/screens/login/components/forget_password_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LoginScreen(),
      );
    case RegistrationScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const RegistrationScreen(),
      );
    case Dashboard.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Dashboard(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );
    case Orders.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Orders(),
      );

    case ForgetPassword.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ForgetPassword(),
      );
    case PasswordResetPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const PasswordResetPage(),
      );
    case PersonalDetails.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const PersonalDetails(),
      );
    case EditName.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const EditName(),
      );
    case EditEmail.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const EditEmail(),
      );
    case EditPassword.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const EditPassword(),
      );
    case VerifyOTP.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const VerifyOTP(),
      );
    case CategoryScreen.routeName:
      final arg = routeSettings.arguments as CategoryScreen;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CategoryScreen(
                category: arg.category,
                image: arg.image,
              ));

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}
