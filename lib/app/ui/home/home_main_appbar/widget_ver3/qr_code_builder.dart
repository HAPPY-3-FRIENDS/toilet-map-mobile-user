import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:toiletmap/app/utils/constants.dart';

class QRCodeBuilder extends StatefulWidget {
  static bool qrCode = false;
  final String data;
  final int accountId;

  const QRCodeBuilder({Key? key, required this.data, required this.accountId})
      : super(key: key);

  @override
  State<QRCodeBuilder> createState() => _QRCodeBuilderState();
}

class _QRCodeBuilderState extends State<QRCodeBuilder> {
  int time = 30;
  Timer? timer;
  DateTime date = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    QRCodeBuilder.qrCode = true;
    startTimer();
    print(QRCodeBuilder.qrCode);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    QRCodeBuilder.qrCode = false;
    print(QRCodeBuilder.qrCode);
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() => time--);
      if (time == 0) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Container(
          alignment: Alignment.center,
          child: Text("Mã thanh toán ${widget.data}", style: AppText.appbarText2,),
        ),
        titleTextStyle: AppText.alertText,
        elevation: 5,
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppNumber.h60)),
        content: Container(
          height: 380.h,
          width: 250.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              QrImage(
                data: '${widget.accountId} - ${widget.data} - $date',
                version: QrVersions.auto,
                gapless: true,
                size: 200.w, //Phuong phone 280
                padding: EdgeInsets.zero,
              ),
              Text('Mã sẽ biến mất sau $time giây', style: AppText.detailText2,),
            ],
          ),
        )
    );


      GestureDetector(
        onTap: () {
          AwesomeDialog(
              context: context,
              dialogType: DialogType.noHeader,
              animType: AnimType.topSlide,
              showCloseIcon: true,
              body: Container(
                height: 400.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    QrImage(
                      data: '${widget.accountId} - ${widget.data} - $date',
                      version: QrVersions.auto,
                      gapless: false,
                      size: 280.w,
                    ),
                    Text('Mã sẽ biến mất sau $time giây', style: AppText.detailText2,),
                  ],
                ),
              )
          ).show();
        },
        child: Icon(Icons.compare_arrows_sharp, color: Colors.black, size: 15.w,)
    );


      AlertDialog(
      title: Container(
        alignment: Alignment.center,
        child: Text("Mã thanh toán ${widget.data}", style: AppText.appbarText2,),
      ),
      titleTextStyle: AppText.alertText,
      elevation: 5,
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppNumber.h60)),
      content: Container(
        height: AppSize.heightScreen / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            QrImage(
              data: '${widget.accountId} - ${widget.data} - $date',
              version: QrVersions.auto,
              gapless: false,
              size: AppSize.widthScreen * 0.7,
            ),
            Text('Mã sẽ biến mất sau $time giây', style: AppText.detailText2,),
          ],
        ),
      )
    );
  }
}