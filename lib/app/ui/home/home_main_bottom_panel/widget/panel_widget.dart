import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toiletmap/app/models/toilet/toiletFacilities/toiletFacilities.dart';
import 'package:toiletmap/app/repositories/shared_preferences_repository.dart';
import 'package:toiletmap/app/repositories/toilet_repository.dart';
import 'package:toiletmap/app/ui/home/home_main_bottom_panel/widget/announcement_list_frame.dart';
import 'package:toiletmap/app/ui/home/home_main_bottom_panel/widget/toilet_in_list_frame.dart';

import '../../../../main.dart';
import '../../../../models/announcement/announcement.dart';
import '../../../../models/toilet/toilet.dart';
import '../../../../repositories/announcement_repository.dart';
import '../../../../utils/constants.dart';

class PanelWidget extends StatefulWidget {

  PanelWidget({Key? key}) : super(key: key);

  @override
  State<PanelWidget> createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: AppBoxDecoration.boxDecoration5,
          child: ListView(
            controller: ScrollController(),
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 80.h,
                decoration: AppBoxDecoration.boxDecoration4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        height: 4.h,
                        width: 120.w,
                        decoration: AppBoxDecoration.boxDecoration2
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Nhà vệ sinh gần đây", style: AppText.titleText2,),
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
                                Container(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: buildNearbyToiletList(),
              )
            ],
          ),
    );
  }

  Widget buildNearbyToiletList(){
    return RefreshIndicator(
        key: _refreshIndicatorKey,
        color: AppColor.primaryColor1,
        backgroundColor: Colors.white,
        strokeWidth: 2.0,
        onRefresh: () async {
          // Replace this delay with the code to be executed during refresh
          // and return a Future when code finishs execution.
          Location _location = Location();
          sharedPreferences = await SharedPreferences.getInstance();
          LocationData locationData = await _location.getLocation();
          SharedPreferencesRepository().setCurrentLatLong(locationData.latitude, locationData.longitude);
          setState(() {

          });
          },
        // Pull from top to show refresh indicator.
        child: Container(
          height: 530.h,
          child: (
              FutureBuilder<List<Toilet>?> (
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
                      int showerRoom = 0;
                      int normalRoom = 0;
                      int disabilityRoom = 0;

                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          Toilet toilet = snapshot.data![index];
                          toilet.toiletFacilities.forEach((element) {
                            if (element.facilityName == "Phòng vệ sinh") {
                              normalRoom = element.quantity;
                            }
                            if (element.facilityName == "Phòng vệ sinh dành cho người khuyết tật") {
                              disabilityRoom = element.quantity;
                            }
                            if (element.facilityName == "Phòng tắm") {
                              showerRoom = element.quantity;
                            }
                          });
                          List<ToiletFacilities> list = [];
                          toilet.toiletFacilities.forEach((element) {
                            if (element.facilityType != "Phòng" && element.quantity > 0) {
                              list.add(element);
                            }
                          });
                          print('hihihine: '+ list.length.toString());

                          if (index == 0) {
                            return Column(
                              children: [
                                ToiletInListFrame(
                                  toiletId: toilet.id,
                                  time: toilet.openTime + " - " + toilet.closeTime,
                                  toiletImagesList: toilet.toiletImageSources,
                                  toiletName: toilet.toiletName,
                                  address: toilet.address + ", " + toilet.ward + ", " + toilet.district + ", " + toilet.province,
                                  price: (toilet.free == false)
                                      ? '${toilet.minPrice} - ${toilet.maxPrice} VND/lượt'
                                      : 'Miễn phí',
                                  toiletImage: toilet.toiletImageSources[0],
                                  star: toilet.ratingStar,
                                  nearBy: toilet.nearBy,
                                  showerRoom: showerRoom,
                                  normalRoom: normalRoom,
                                  disabilityRoom: disabilityRoom,
                                  facilities: list,
                                  duration: toilet.duration!,
                                  distance: toilet.distance!,
                                ),
                                FutureBuilder<List<Announcement>?> (
                                    future: AnnouncementRepository().getAnnouncement(),
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
                                        return AnnouncementListFrame(announcements: snapshot.data!,);
                                      }
                                      return Container();
                                    }
                                ),
                                Container(height: 10.h, color: AppColor.appBackground,),
                              ],
                            );
                          }
                          return ToiletInListFrame(
                            toiletId: toilet.id,
                            time: toilet.openTime + " - " + toilet.closeTime,
                            toiletImagesList: toilet.toiletImageSources,
                            toiletName: toilet.toiletName,
                            address: toilet.address + ", " + toilet.ward + ", " + toilet.district + ", " + toilet.province,
                            price: (toilet.free == false)
                                ? '${toilet.minPrice} - ${toilet.maxPrice} VND/lượt'
                                : 'Miễn phí',
                            toiletImage: toilet.toiletImageSources[0],
                            star: toilet.ratingStar,
                            nearBy: toilet.nearBy,
                            showerRoom: showerRoom,
                            normalRoom: normalRoom,
                            disabilityRoom: disabilityRoom,
                            facilities: list,
                            duration: toilet.duration!,
                            distance: toilet.distance!,
                          );
                        },
                      );
                    }
                    return Center(child: Text('Lỗi'));
                  })
          ),
        ),
    );
  }

}
