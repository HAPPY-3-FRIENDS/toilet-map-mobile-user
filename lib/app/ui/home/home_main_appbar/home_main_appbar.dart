import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import 'widget/payment_frame.dart';
import 'widget/qr_code_button.dart';

class HomeMainAppBar extends StatelessWidget {
  const HomeMainAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.heightScreen / 3.8,
      child: AppBar(
        shape: AppShapeBorder.shapeBorder1,
        elevation: 10,

        leading: Icon(Icons.person),
        title: Text('Xin chào Thúy Phượng', style: TextStyle(fontSize: AppNumber.h45),),
        actions: [
          Icon(Icons.history),
          Padding(padding: EdgeInsets.only(right: 5))
        ],

        flexibleSpace: Container(
            decoration: AppBoxDecoration.boxDecorationWithGradient1
        ),


        bottom: PreferredSize(
            preferredSize: Size.fromHeight(150),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const[
                    PaymentFrame(),
                    QRCodeButton(),
                  ],
                ),
                const SizedBox(height: 20,)
              ],
            )
        ),
      ),
    );
  }
}
