import 'package:flutter/material.dart';
import 'package:toiletmap/app/ui/home/home_main_appbar/widget_ver3/payment_method_changing.dart';

import '../../../../utils/routes.dart';

class PaymentFrame extends StatelessWidget {
  const PaymentFrame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 250,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(offset: Offset(0.0, 10.0), blurRadius: 10.0, color: Colors.black26),
        ],
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Thanh toán bằng số lượt (Mặc định)'),
                /*SizedBox(
                  height: 25,
                  child: IconButton(
                    onPressed: () => showDialog(
                        context: context,
                        builder: (_) =>()),
                    icon: Icon(Icons.compare_arrows_sharp, size: 20),),
                ),*/
              ],
            ),
            const Text('30 lượt', style: TextStyle(fontSize: 30),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 30,
                  child: ElevatedButton.icon(
                    onPressed: () => {
                      Navigator.pushNamed(context, Routes.topUpMoneyMainScreen)
                    },
                    icon: Icon(Icons.login, size: 15,),
                    label: Text("Nạp số dư"),
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.buyComboMainScreen);
                    },
                    icon: Icon(Icons.add_shopping_cart, size: 15),
                    label: Text("Mua gói lượt"),
                  ),
                ),
              ],
            ),
          ]
      ),
    );
  }
}
