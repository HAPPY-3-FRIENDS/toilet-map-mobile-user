import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class PanelWidget extends StatelessWidget {
  final ScrollController controller;

  const PanelWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[AppColor.gradientColor2, AppColor.gradientColor1]),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(height: 40,),
            buildAboutText(),
          ],
        )
    );
  }

  Widget buildAboutText(){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Hiển thị danh sách nhà vệ sinh', style: TextStyle(color: Colors.white, fontSize: 20)),
        ],
      ),
    );
  }

}
