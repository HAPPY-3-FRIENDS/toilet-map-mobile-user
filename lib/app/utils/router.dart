import 'package:flutter/material.dart';
import 'package:toiletmap/app/ui/home/home_main_screen.dart';
import 'package:toiletmap/app/ui/login/login_main_screen.dart';
import 'package:toiletmap/app/ui/login/login_otp_confirmation_screen.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'LoginMainScreen':
        return MaterialPageRoute(builder: (_) => const LoginMainScreen());
      case 'LoginOTPConfirmationScreen':
        return MaterialPageRoute(builder: (_) => const LoginOTPConfirmationScreen());
      case 'HomeMainScreen':
        return MaterialPageRoute(builder: (_) => const HomeMainScreen());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}