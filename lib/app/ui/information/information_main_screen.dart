import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toiletmap/app/repositories/user_info_repository.dart';
import 'package:toiletmap/app/ui/login/login_main_screen.dart';

import '../../models/userInfo/user_info.dart';
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
              decoration: AppBoxDecoration.boxDecorationWithGradientNoBorder1,
            ),
          ),

          body: Container(
            padding: EdgeInsets.all(AppSize.widthScreen / 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FutureBuilder<UserInfo?> (
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
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: (snapshot!.data!.avatar != null)
                                      ? CircleAvatar(
                                      radius: AppSize.widthScreen / 7,
                                      backgroundImage: NetworkImage(snapshot!.data!.avatar!)
                                  )
                                      : CircleAvatar(
                                    radius: AppSize.widthScreen / 7,
                                    backgroundImage: AssetImage('assets/default-avatar.png'),
                                  ),
                                ),
                                VerticalDivider(
                                  color: AppColor.primaryColor1,
                                  thickness: 1,
                                  indent: AppSize.widthScreen / 35,
                                  endIndent: AppSize.widthScreen / 35,
                                ),
                                Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(snapshot!.data!.fullName!, style: AppText.titleText2,),
                                        Text('**********', style: AppText.titleText2,),
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
                                                  Text('Mã cá nhân', style: AppText.titleText2,),
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
                        );
                      }
                      return Center(child: Text('Lỗi'));
                    }),
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
                          await prefs.clear();
                          Navigator.of(context).pushAndRemoveUntil(
                            //change Route to build apk
                              MaterialPageRoute(builder: (context) => const LoginMainScreen()), (
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
