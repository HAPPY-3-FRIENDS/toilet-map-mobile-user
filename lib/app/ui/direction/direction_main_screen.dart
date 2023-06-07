import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toiletmap/app/ui/direction/widget/direction_bottom_panel.dart';
import 'package:toiletmap/app/ui/direction/widget/direction_map_frame.dart';

import '../../models/toilet/toilet.dart';
import '../../repositories/toilet_repository.dart';
import '../../utils/constants.dart';

class DirectionMainScreen extends StatelessWidget {
  int id;

  DirectionMainScreen({required this.id, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("This is direction screen: " + id.toString());

    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(100.h),
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.only(top: 20.h),
                child: AppBar(
                  automaticallyImplyLeading: false,

                  title: Text('Chỉ đường'),
                  titleTextStyle: AppText.appbarTitleText2,
                  centerTitle: true,
                  toolbarHeight: 100.h,
                  backgroundColor: Colors.white,
                  elevation: 0,

                  iconTheme: IconThemeData(
                      color: AppColor.primaryColor1
                  ),
                ),
              ),
            ),

            body: FutureBuilder<Toilet?> (
                future: ToiletRepository().getToiletByToiletId(id),
                builder: (context, snapshot)  {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(
                            color: AppColor.primaryColor1,
                            strokeWidth: 2.0
                        )
                    );
                  }
                  if (snapshot.hasData) {
                    return DirectionMapFrame(toilet: snapshot.data!);
                  }
                  return Center(child: Text('Lỗi'));
                }
            ),
        )
    );
  }
}
