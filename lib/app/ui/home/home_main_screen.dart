import 'package:flutter/material.dart';
import 'package:toiletmap/app/ui/home/widgets/panel_widget.dart';
import 'package:toiletmap/app/ui/home/widgets/payment_frame.dart';
import 'package:toiletmap/app/ui/home/widgets/qr_code_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../utils/constants.dart';

class HomeMainScreen extends StatefulWidget {
  const HomeMainScreen({Key? key}) : super(key: key);

  @override
  State<HomeMainScreen> createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends State<HomeMainScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0))
          ),
          elevation: 10,
          titleSpacing: 0,


          leading: Icon(Icons.person),
          title: Text('Xin chào Thúy Phượng', style: TextStyle(fontSize: 16),),
          actions: [Icon(Icons.history), Padding(padding: EdgeInsets.only(right: 5))],

          flexibleSpace: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0)),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[AppColor.gradientColor1, AppColor.gradientColor2]),
            ),
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
        body: SlidingUpPanel(
          body: Container(
            color: Colors.white,
          ),
          panelBuilder: (controller) =>
              PanelWidget(
                  controller: controller
              ),
        )
      ),
    );
  }
}
