import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toiletmap/app/models/toilet/toiletFacilities/toiletFacilities.dart';
import 'package:toiletmap/app/repositories/toilet_repository.dart';
import 'package:toiletmap/app/ui/home/home_main_bottom_panel/widget/announcement_list_frame.dart';
import 'package:toiletmap/app/ui/home/home_main_bottom_panel/widget/toilet_in_list_frame.dart';

import '../../../models/announcement/announcement.dart';
import '../../../models/toilet/toilet.dart';
import '../../../repositories/announcement_repository.dart';
import '../../../utils/constants.dart';

class NearbyListWidget extends StatelessWidget {

  const NearbyListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppBoxDecoration.boxDecoration5,
      child: ListView(
        controller: ScrollController(),
        padding: EdgeInsets.zero,
        children: [
          Expanded(
            child: buildNearbyToiletList(),
          )
        ],
      ),
    );
  }

  Widget buildNearbyToiletList(){
    return Container(
      child: Column(
        children: [
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
          Container(height: 10.h, color: Colors.white,),
          SingleChildScrollView(
            child: Container(
              height: 650.h,
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
                          int showerRoom = toilet.toiletFacilities[0].quantity;
                          int normalRoom = toilet.toiletFacilities[1].quantity;
                          int disabilityRoom = toilet.toiletFacilities[2].quantity;
                          List<ToiletFacilities> list = [];
                          toilet.toiletFacilities.forEach((element) {
                            if (element.facilityType != "Phòng" && element.quantity > 0) {
                              list.add(element);
                            }
                          });
                          print('hihihine: '+ list.length.toString());

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
                          );
                        },
                      );
                    }
                    return Center(child: Text('Lỗi'));
                  }),
            )
          )
        ],
      ),
    );



      SingleChildScrollView(
      child: Container(
        height: 800.h,
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
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        Toilet toilet = snapshot.data![index];
                        int showerRoom = toilet.toiletFacilities[0].quantity;
                        int normalRoom = toilet.toiletFacilities[1].quantity;
                        int disabilityRoom = toilet.toiletFacilities[2].quantity;
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
                              ),
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
