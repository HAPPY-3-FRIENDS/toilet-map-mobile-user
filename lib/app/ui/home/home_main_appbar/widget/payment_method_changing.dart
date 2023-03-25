import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';

class PaymentMethodChanging extends StatefulWidget {
  const PaymentMethodChanging({Key? key}) : super(key: key);

  @override
  State<PaymentMethodChanging> createState() => _PaymentMethodChangingState();
}

class _PaymentMethodChangingState extends State<PaymentMethodChanging> {
  String _service = '0';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColor.primaryColor2,
      contentPadding: EdgeInsets.zero,
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

      title: Center(child: Text('CÀI ĐẶT THANH TOÁN', style: TextStyle(
        fontWeight: FontWeight.w600, fontSize: 18
      ),)),
      titlePadding: EdgeInsets.all(20),
      titleTextStyle: AppText.alertText,

      content: Container(
        height: 150,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.only(left: 20), child: Text('Chọn phương thức thanh toán', style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w800
            ),),),
            SizedBox(height: 10,),
            RadioListTile(
              visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
              title: Text('Lượt hiện có (30 lượt)', style: AppText.alertText,),
              value: '0',
              groupValue: _service,
              onChanged: (value) => setService(value),
            ),
            RadioListTile(
              visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
              title: Text('Số dư tài khoản (50.000 VND)', style: AppText.alertText,),
              value: '1',
              groupValue: _service,
              onChanged: (value) => setService(value),
            ),
          ],
        ),
      ),

      actions: [
        Center(
          child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Lưu", style: TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 16
              ),)),
        )
      ],
      actionsPadding: EdgeInsets.all(0),
    );
  }

  void setService(String? value) {
    setState(() {
      _service = value!;
    });
    print(_service);
  }
}