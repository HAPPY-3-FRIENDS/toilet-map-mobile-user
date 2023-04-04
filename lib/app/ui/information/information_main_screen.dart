import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants.dart';
import '../login/login_otp_confirmation_screen.dart';

class InformationMainScreen extends StatelessWidget {
  const InformationMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Thông tin cá nhân'),
            titleTextStyle: AppText.appbarTitleText1,
            centerTitle: true,
            toolbarHeight: AppSize.heightScreen / 10,
            backgroundColor: Colors.transparent,

            flexibleSpace: Container(
              height: AppSize.heightScreen / 10,
              decoration: AppBoxDecoration.boxDecorationWithGradient1,
            ),
          ),

          body: Container(
            padding: EdgeInsets.all(AppSize.widthScreen / 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: CircleAvatar(
                            radius: AppSize.widthScreen / 7,
                            backgroundImage: NetworkImage('https://scontent.fsgn8-3.fna.fbcdn.net/v/t39.30808-6/319192484_3397906417112328_3843130775408765333_n.jpg?stp=cp6_dst-jpg&_nc_cat=106&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=xgoClnZngHMAX_qClEV&_nc_ht=scontent.fsgn8-3.fna&oh=00_AfD-qsfhayyVBHXTb6rL_REZeLB70L0GU9gWzzXLIWBldw&oe=64277075'),
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('    Đức Quân', style: AppText.titleText2,),
                                Text('    ********57', style: AppText.titleText2,),
                              ],
                            )),
                        VerticalDivider(
                          color: AppColor.primaryColor1,
                          thickness: 1,
                          indent: AppSize.widthScreen / 35,
                          endIndent: AppSize.widthScreen / 35,
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () => showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                  elevation: 5,
                                  alignment: Alignment.center,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppNumber.h60)),
                                  content: Container(
                                    height: AppSize.widthScreen * 0.8,
                                    child: Column(
                                      children: [
                                        QrImage(
                                          data: '23',
                                          version: QrVersions.auto,
                                          gapless: false,
                                          size: AppSize.widthScreen * 0.7,
                                        ),
                                        Text('Mã dùng để nạp tiền', style: AppText.titleText2,),
                                      ],
                                    ),
                                  )
                              )),
                            child:  QrImage(
                              data: '23',
                              version: QrVersions.auto,
                              gapless: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: AppColor.primaryColor2,
                      thickness: 1,
                      indent: AppSize.widthScreen / 35,
                      endIndent: AppSize.widthScreen / 35,
                    ),
                    Container(
                      padding: EdgeInsets.all(AppSize.widthScreen / 30),
                      child: Text("Thiết lập thông tin cá nhân"),
                    ),
                    Divider(
                      color: AppColor.primaryColor2,
                      thickness: 1,
                      indent: AppSize.widthScreen / 35,
                      endIndent: AppSize.widthScreen / 35,
                    ),
                    Container(
                      padding: EdgeInsets.all(AppSize.widthScreen / 30),
                      child: Text("Lịch sử"),
                    ),
                    Divider(
                      color: AppColor.primaryColor2,
                      thickness: 1,
                      indent: AppSize.widthScreen / 35,
                      endIndent: AppSize.widthScreen / 35,
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  height: AppNumber.h15,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: AppColor.primaryColor2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppSize.widthScreen /20))),
                      onPressed: () async {
                        try {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.remove('accessToken');
                          await prefs.remove('username');
                          await prefs.remove('accountId');
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => const LoginOTPConfirmationScreen()), (
                              route) => false);
                        } catch (error) {
                          print(error);
                        }
                      },
                      child: Text("Đăng xuất", style: TextStyle(color: Colors.black45),)
                  ),
                )
              ],
            ),
          ),
      ),
    );
  }
}
