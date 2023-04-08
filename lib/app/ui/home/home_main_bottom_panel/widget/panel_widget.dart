

import 'package:flutter/material.dart';
import 'package:toiletmap/app/repositories/toilet_repository.dart';
import 'package:toiletmap/app/ui/home/home_main_bottom_panel/widget/toilet_in_list_frame.dart';

import '../../../../models/toilet/toilet.dart';
import '../../../../utils/constants.dart';

class PanelWidget extends StatelessWidget {

  const PanelWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: AppBoxDecoration.boxDecoration3,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: AppSize.heightScreen / 10,
              decoration: AppBoxDecoration.boxDecoration4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      height: AppNumber.h200,
                      width: AppSize.widthScreen / 3,
                      decoration: AppBoxDecoration.boxDecoration2
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: AppNumber.h50,right: AppNumber.h50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text("Nhà vệ sinh gần đây", style: AppText.titleText2,),
                            InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: AppSize.widthScreen / 60),
                                child: Icon(Icons.refresh, size: AppSize.widthScreen / 20,),
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Chú ý'),
                                  content: const Text('Đã có lỗi xảy ra!'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Xác nhận'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Row(
                            children: [
                              Icon(Icons.filter_alt),
                              Text('Lọc'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            buildNearbyToiletList(),
          ],
        )
    );
  }

  Widget buildNearbyToiletList(){


    return Container(
      child: FutureBuilder<List<Toilet>?> (
          future: ToiletRepository().getToiletsNearbyByCurrentLatLong(),
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
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  Toilet toilet = snapshot.data![index];
                  return ToiletInListFrame(
                    toiletName: toilet.toiletName,
                    address: toilet.address + ", " + toilet.ward + ", " + toilet.district + ", " + toilet.province,
                    price: (toilet.free == false)
                        ? '${toilet.minPrice} - ${toilet.maxPrice} VND/lượt'
                        : 'Miễn phí',
                    toiletImage: toilet.toiletImageSources[0],
                    star: toilet.ratingStar,
                    nearBy: toilet.nearBy,
                  );
                },
              );
            }
            return Center(child: Text('Lỗi'));
          }),
    );
  }

}
