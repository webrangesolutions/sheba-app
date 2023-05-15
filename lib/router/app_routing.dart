import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sheba_financial/screens/PrivacyPolicy.dart';
import 'package:sheba_financial/screens/account.dart';
import 'package:sheba_financial/screens/changePassword.dart';
import 'package:sheba_financial/screens/contactUs.dart';
import 'package:sheba_financial/screens/dashboard.dart';
import 'package:sheba_financial/screens/editProfile.dart';
import 'package:sheba_financial/screens/forgetPassword.dart';

import 'package:sheba_financial/screens/intro.dart';
import 'package:sheba_financial/screens/otp.dart';
import 'package:sheba_financial/screens/register.dart';
import 'package:sheba_financial/screens/scan.dart';
import 'package:sheba_financial/screens/settings.dart';
import 'package:sheba_financial/screens/users.dart';

import '../screens/expenses.dart';
import '../screens/home.dart';
import '../screens/login.dart';
import '../screens/receipt_details.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/IntroScreen':
        return MaterialPageRoute(builder: (_) => IntroScreen());
      case '/HomeScreen':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/SignupScreen':
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case '/OtpScreen':
        return MaterialPageRoute(builder: (_) => OtpScreen());
      case '/LoginScreen':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/DashboardScreen':
        return MaterialPageRoute(builder: (_) => DashboardScreen());
      case '/AccountScreen':
        return MaterialPageRoute(builder: (_) => AccountScreen());
      case '/ScanScreen':
        return MaterialPageRoute(builder: (_) => ScanScreen());
      case '/ExpensesScreen':
        return MaterialPageRoute(builder: (_) => ExpensesScreen());
      // case '/ReceiptDetails':
      //   return MaterialPageRoute(builder: (_) => ReceiptDetailsScreen());
      case '/UsersScreen':
        return MaterialPageRoute(builder: (_) => UsersScreen());
      case '/settingsScreen':
        return MaterialPageRoute(builder: (_) => SettingsScreen());
      case '/PrivacyPolicyScreen':
        return MaterialPageRoute(builder: (_) => PrivacyPolicyScreen());
      case '/ContactUsScreen':
        return MaterialPageRoute(builder: (_) => ContactUsScreen());
      case '/EditProfileScreen':
        return MaterialPageRoute(builder: (_) => EditProfileScreen());
      case '/ChangePasswordScreen':
        return MaterialPageRoute(builder: (_) => ChnagePasswordScreen());
      case '/forgetPasswordScreen':
        return MaterialPageRoute(builder: (_) => ForgetPassword());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
