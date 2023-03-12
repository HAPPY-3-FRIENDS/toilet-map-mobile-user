import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:toiletmap/app/utils/constants.dart';

class QRCodeBuilder extends StatelessWidget {
  final String data;

  const QRCodeBuilder({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
        alignment: Alignment.center,
          child: Text("QUÉT MÃ NÀY ĐỂ THANH TOÁN"),
        ),
      titleTextStyle: AppText.alertText,
      elevation: 5,
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: QrImage(
              data: data,
              version: QrVersions.auto,
              gapless: false,
              size: 220,
            ),
    );
  }
}
