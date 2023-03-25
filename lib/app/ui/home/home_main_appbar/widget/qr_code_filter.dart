import 'package:flutter/material.dart';
import 'package:toiletmap/app/ui/home/home_main_appbar/widget_ver3/qr_code_builder.dart';
import 'package:toiletmap/app/utils/constants.dart';

class QRCodeFilter extends StatefulWidget {
  const QRCodeFilter({Key? key}) : super(key: key);

  @override
  State<QRCodeFilter> createState() => _QRCodeFilterState();
}

class _QRCodeFilterState extends State<QRCodeFilter> {
  String _service = 'Đi vệ sinh (tiểu tiện)';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColor.primaryColor2,
      contentPadding: EdgeInsets.zero,
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

      title: Center(child: Text('CHỌN NHU CẦU SỬ DỤNG')),
      titlePadding: EdgeInsets.all(20),
      titleTextStyle: AppText.alertText,

      content: Container(
        height: 200,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RadioListTile(
              visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
              title: Text('Đi vệ sinh (tiểu tiện)', style: AppText.alertText,),
                subtitle: Text('1 lượt hoặc 2.000đ / lần'),
                value: 'Đi vệ sinh (tiểu tiện)',
                groupValue: _service,
                onChanged: (value) => setService(value),
            ),
            RadioListTile(
              visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
              title: Text('Đi vệ sinh (đại tiện)', style: AppText.alertText,),
              subtitle: Text('2 lượt hoặc 5.000đ / lần'),
              value: 'Đi vệ sinh (đại tiện)',
              groupValue: _service,
              onChanged: (value) => setService(value),
            ),
            RadioListTile(
              visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
              title: Text('Đi tắm', style: AppText.alertText,),
              subtitle: Text('3 lượt hoặc 8.000đ / lần'),
              value: 'Đi tắm',
              groupValue: _service,
              onChanged: (value) => setService(value),
            ),
          ],
        ),
      ),
      
      actions: [
        Center(
          child: TextButton(
              onPressed: () => showDialog(
                  context: context,
                  builder: (_) => QRCodeBuilder(data: '1 - ${_service} - ${DateTime.now()}')
              ),
              /*()  {
                Navigator.of(context).pop();
                showDialog(context: context, builder: (_) => QRCodeBuilder(data: '1 - ${_service} - ${DateTime.now()}'));
              },*/
              child: Text("Lấy mã QR", style: AppText.alertText,)),
        )
      ],
      actionsPadding: EdgeInsets.all(10),
    );
  }

  void setService(String? value) {
    setState(() {
      _service = value!;
    });
    print(_service);
  }
}
