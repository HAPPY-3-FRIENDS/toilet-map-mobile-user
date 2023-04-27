import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toiletmap/app/repositories/shared_preferences_repository.dart';
import 'package:toiletmap/app/repositories/user_info_repository.dart';
import 'package:toiletmap/app/ui/home/home_main_appbar/widget_ver3/home_appbar_action_frame.dart';
import 'package:toiletmap/app/ui/login/login_main_screen.dart';

import '../../../models/userInfo/user_info.dart';
import '../../../repositories/auth_repository.dart';
import '../../../utils/constants.dart';
import '../../../utils/routes.dart';
import '../../login/login_otp_confirmation_screen.dart';

class HomeMainAppbarVer3 extends StatelessWidget {
  const HomeMainAppbarVer3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.heightScreen / 3.5,
      child: AppBar(
        shape: AppShapeBorder.shapeBorder1,
        elevation: 10,

        leading: InkWell(
          onTap: () async {
            Navigator.pushNamed(context, Routes.informationMainScreen);
            /*try {
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('accessToken');
              await prefs.remove('username');
              await prefs.remove('userId');
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginOTPConfirmationScreen()), (
                  route) => false);
            } catch (error) {
              print(error);
            }*/
          },
          child: Icon(Icons.person, size: AppSize.widthScreen / 15, color: Colors.white,),
        ),


        titleSpacing: 0,
        title: FutureBuilder<UserInfo?> (
            future: UserInfoRepository().getUserInfo(),
            builder: (context, snapshot)  {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                        color: AppColor.primaryColor1,
                        strokeWidth: 2.0
                    )
                );
              }
              if (snapshot.hasData) {
                return Text('Xin chào ${snapshot.data!.fullName}', style: TextStyle(fontSize: AppNumber.h45),);
              }
              return Center(child: Text('Lỗi'));
            }),

        actions: [
          InkWell(
            onTap: () => {
              Navigator.pushNamed(context, Routes.historyMainScreen),
            },
            child: Icon(Icons.history, size: AppSize.widthScreen / 15, color: Colors.white,),
          ),
          Padding(padding: EdgeInsets.only(right: AppSize.widthScreen / 30))
        ],

        flexibleSpace: Container(
            decoration: AppBoxDecoration.boxDecorationWithGradient1
        ),


        bottom: PreferredSize(
            preferredSize: Size.fromHeight(AppSize.heightScreen / 4),
            child: Container(
              padding: EdgeInsets.only(
                left: AppSize.widthScreen / 40,
                right: AppSize.widthScreen / 40,
                bottom: AppSize.widthScreen / 30,
              ),
              child: ActionFrame(),
            ),
        ),
      ),
    );
  }
}