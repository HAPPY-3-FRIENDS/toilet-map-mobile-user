import 'package:flutter/material.dart';
import 'package:toiletmap/app/ui/home/home_main_bottom_panel/widget/toilet_in_list_frame.dart';

import '../../../../utils/constants.dart';

class PanelWidget extends StatelessWidget {
  final ScrollController controller;

  const PanelWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: AppBoxDecoration.boxDecorationWithGradient2,
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
          //ToiletInListFrame(),
        ],
      ),
    );
  }

}
