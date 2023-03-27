import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toiletmap/app/main.dart';
import 'package:toiletmap/app/models/accessToken/access_token.dart';
import 'package:toiletmap/app/repositories/auth_repository.dart';

import '../../utils/constants.dart';
import '../../utils/routes.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  String name = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chờ xác nhận'),
          titleTextStyle: AppText.appbarTitleText1,
          centerTitle: true,
          toolbarHeight: AppSize.heightScreen / 7,
          backgroundColor: Colors.transparent,

          flexibleSpace: Container(
            height: AppSize.heightScreen / 6,
            decoration: AppBoxDecoration.boxDecorationWithGradient1,
          ),
        ),

        body: Container(
            padding: EdgeInsets.only(
                left: AppSize.widthScreen / 20,
                right: AppSize.widthScreen / 20,
                top: AppSize.heightScreen / 20,
                bottom: AppSize.heightScreen / 20
            ),
            height: AppSize.heightScreen,
            width: AppSize.widthScreen,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Form(
                  child: TextFormField(
                    onChanged: (value) => setState(() => {
                      name = value
                    }),
                    maxLength: 50,
                    decoration: InputDecoration(
                      hintText: "Nhập họ tên của bạn",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSize.widthScreen /20),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSize.widthScreen /20),
                        borderSide: BorderSide(color: AppColor.primaryColor1),
                      ),
                    ),
                  ),
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
                          AuthRepository().createUserWithPhone(name);
                          Navigator.pushNamed(context, Routes.homeMainScreen);
                        } catch (e) {
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Chú ý'),
                                content: const Text('Vui lòng nhập tên'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Xác nhận'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: Text("Xác nhận", style: TextStyle(color: Colors.black45),)
                  ),
                )
              ],
            )
        ),
    );
  }
}
