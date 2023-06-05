import 'package:flutter/material.dart';
import 'package:toiletmap/app/models/announcement/announcement.dart';
import 'package:toiletmap/app/models/combo/comboArgument.dart';
import 'package:toiletmap/app/models/placeDetail/place_detail.dart';
import 'package:toiletmap/app/models/toilet/toiletArgument.dart';
import 'package:toiletmap/app/models/toilet/toiletArgument2.dart';
import 'package:toiletmap/app/ui/home/home_main_screen.dart';
import 'package:toiletmap/app/ui/information/information_change_main_screen.dart';
import 'package:toiletmap/app/ui/information/information_change_phone_confirm_screen.dart';
import 'package:toiletmap/app/ui/information/information_change_phone_screen.dart';
import 'package:toiletmap/app/ui/login/login_main_screen.dart';
import 'package:toiletmap/app/ui/login/login_otp_confirmation_screen.dart';

import '../models/checkin/checkin.dart';
import '../ui/announcement/announcement_main_screen.dart';
import '../ui/combo/buy_combo_main_screen.dart';
import '../ui/direction/direction_main_screen.dart';
import '../ui/history/history_main_screen.dart';
import '../ui/information/information_change_name_screen.dart';
import '../ui/information/information_linked_app_screen.dart';
import '../ui/information/information_main_screen.dart';
import '../ui/information/information_payment_screen.dart';
import '../ui/information/information_service_price_screen.dart';
import '../ui/login/create_account_screen.dart';
import '../ui/money/top_up_money_main_screen.dart';
import '../ui/navigation/navigation_test_screen.dart';
import '../ui/rating/rating_list_screen.dart';
import '../ui/rating/rating_main_screen.dart';
import '../ui/search/search_main_screen.dart';
import '../ui/search/search_map_screen.dart';
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
        final index = settings.arguments as ComboArgument;
        return MaterialPageRoute(builder: (_) => BuyComboMainScreen(comboArgument: index,));
      case 'HistoryMainScreen':
        return MaterialPageRoute(builder: (_) => const HistoryMainScreen());
      case 'InformationMainScreen':
        return MaterialPageRoute(builder: (_) => const InformationMainScreen());
      case 'ToiletDetailMainScreen':
        final index = settings.arguments as ToiletArgument;
        return MaterialPageRoute(builder: (_) => ToiletDetailMainScreen(toiletArgument: index));
      case 'DirectionMainScreen':
        final index = settings.arguments as int;
        return MaterialPageRoute(builder: (_) => DirectionMainScreen(id: index,));
      case 'CreateAccountScreen':
        return MaterialPageRoute(builder: (_) => const CreateAccountScreen());
      case 'InformationChangeMainScreen':
        return MaterialPageRoute(builder: (_) => const InformationChangeMainScreen());
      case 'InformationPaymentScreen':
        return MaterialPageRoute(builder: (_) => const InformationPaymentScreen());
      case 'InformationServicePriceScreen':
        return MaterialPageRoute(builder: (_) => const InformationServicePriceScreen());
      case 'RatingListScreen':
        final index1 = settings.arguments as ToiletArgument2;
        return MaterialPageRoute(builder: (_) => RatingListScreen(toiletArgument2: index1));
      case 'InformationChangeNameScreen':
        return MaterialPageRoute(builder: (_) => const InformationChangeNameScreen());
      case 'InformationChangePhoneScreen':
        return MaterialPageRoute(builder: (_) => const InformationChangePhoneScreen());
      case 'InformationChangePhoneConfirmScreen':
        final index1 = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => InformationChangePhoneConfirmScreen(phone: index1,));
      case 'RatingMainScreen':
        final index = settings.arguments as Checkin;
        return MaterialPageRoute(builder: (_) => RatingMainScreen(checkin: index,));
      /*case 'NavigationTestScreen':
        return MaterialPageRoute(builder: (_) => const NavigationTestScreen());*/
      case 'SearchMainScreen':
        return MaterialPageRoute(builder: (_) => const SearchMainScreen());
      case 'SearchMapScreen':
        final index = settings.arguments as PlaceDetail;
        return MaterialPageRoute(builder: (_) => SearchMapScreen(placeDetail: index,));
      case 'AnnouncementMainScreen':
        final index = settings.arguments as Announcement;
        return MaterialPageRoute(builder: (_) => AnnouncementMainScreen(announcement: index,));
      case 'InformationLinkedAppScreen':
        return MaterialPageRoute(builder: (_) => const InformationLinkedAppScreen());

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