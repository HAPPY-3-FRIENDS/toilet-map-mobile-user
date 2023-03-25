import 'package:flutter/material.dart';
import 'package:toiletmap/app/utils/constants.dart';

class TopUpMoneyMainScreen extends StatefulWidget {
  const TopUpMoneyMainScreen({Key? key}) : super(key: key);

  @override
  State<TopUpMoneyMainScreen> createState() => _TopUpMoneyMainScreenState();
}

class _TopUpMoneyMainScreenState extends State<TopUpMoneyMainScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Nạp tiền'),
            titleTextStyle: AppText.appbarText2,
            centerTitle: true,
            toolbarHeight: AppSize.heightScreen / 5,

            flexibleSpace: Container(
              height: AppSize.heightScreen / 5,
              decoration: AppBoxDecoration.boxDecorationWithGradient1,
            ),
          ),

          body: Column(
            children: [
              Text("Số tiền nạp (VND)"),

            ],
          ),
        ),
    );
  }
}
