import 'package:flutter/material.dart';
import 'package:toiletmap/app/models/toilet/toiletArgument.dart';
import 'package:toiletmap/app/ui/home/home_main_screen.dart';
import 'package:toiletmap/app/ui/login/login_main_screen.dart';
import 'package:toiletmap/app/ui/login/login_otp_confirmation_screen.dart';

import '../ui/combo/buy_combo_main_screen.dart';
import '../ui/history/history_main_screen.dart';
import '../ui/information/information_main_screen.dart';
import '../ui/login/create_account_screen.dart';
import '../ui/money/top_up_money_main_screen.dart';
import '../ui/toilet_detail/toilet_detail_main_screen.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'LoginMainScreen':
        return MaterialPageRoute(builder: (_) => const LoginMainScreen());
      case 'LoginOTPConfirmationScreen':
        return MaterialPageRoute(builder: (_) => const LoginOTPConfirmationScreen());
      case 'HomeMainScreen':
        return MaterialPageRoute(builder: (_) => const HomeMainScreen());
      case 'TopUpMoneyMainScreen':
        return MaterialPageRoute(builder: (_) => const TopUpMoneyMainScreen());
      case 'BuyComboMainScreen':
        return MaterialPageRoute(builder: (_) => const BuyComboMainScreen());
      case 'HistoryMainScreen':
        return MaterialPageRoute(builder: (_) => const HistoryMainScreen());
      case 'InformationMainScreen':
        return MaterialPageRoute(builder: (_) => const InformationMainScreen());
      case 'ToiletDetailMainScreen':
        final index = settings.arguments as ToiletArgument;
        return MaterialPageRoute(builder: (_) => ToiletDetailMainScreen(toiletArgument: index,));
      case 'CreateAccountScreen':
        return MaterialPageRoute(builder: (_) => const CreateAccountScreen());
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