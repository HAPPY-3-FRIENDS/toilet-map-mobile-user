import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

import '../../utils/constants.dart';
import '../../utils/extensions.dart';

class HomeMainScreen extends StatefulWidget {
  const HomeMainScreen({Key? key}) : super(key: key);

  @override
  State<HomeMainScreen> createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends State<HomeMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: InkWell(
          onTap: () => {},
          child: Container(
            height: 200,
            width: 200,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColor.primaryColor1,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(offset: Offset(0.0, 20.0), blurRadius: 30.0, color: Colors.black12),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(Icons.qr_code_2,size: 150, color: Colors.white),
                Text('Tạo mã', style: TextStyle(fontSize: 30, color: Colors.white),)
              ],
            ),
          ),
        )
      ),
    );
  }
}
