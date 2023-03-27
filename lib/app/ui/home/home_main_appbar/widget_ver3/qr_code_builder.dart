import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:toiletmap/app/utils/constants.dart';

class QRCodeBuilder extends StatelessWidget {
  final String data;
  final int accountId;

  const QRCodeBuilder({Key? key, required this.data, required this.accountId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
        alignment: Alignment.center,
        child: Text("Mã thanh toán ${data}", style: AppText.appbarText2,),
      ),
      titleTextStyle: AppText.alertText,
      elevation: 5,
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppNumber.h60)),
      content: QrImage(
        data: '${accountId} - ${data} - ${DateTime.now()}',
        version: QrVersions.auto,
        gapless: false,
        size: AppSize.widthScreen * 0.7,
      ),
    );
  }
}
