import 'package:flutter/material.dart';
import 'package:toiletmap/app/ui/home/widgets/qr_code_builder.dart';
import 'package:toiletmap/app/ui/home/widgets/qr_code_filter.dart';

import '../../../utils/constants.dart';

class QRCodeButton extends StatelessWidget {
  const QRCodeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showDialog(
          context: context,
          builder: (_) => QRCodeFilter()),
      child: Container(
        height: 120,
        width: 90,
        padding: EdgeInsets.only(top: 5, bottom: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(offset: Offset(0.0, 10.0), blurRadius: 10.0, color: Colors.black26),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Icon(Icons.qr_code_2,size: 75, color: Colors.black),
            Text('QR thanh toán', style: TextStyle(fontSize: 14, color: Colors.black))
          ],
        ),
      ),
    );
  }
}
