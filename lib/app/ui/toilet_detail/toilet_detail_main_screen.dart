import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quickalert/quickalert.dart';
import 'package:toiletmap/app/repositories/rating_repository.dart';
import 'package:toiletmap/app/repositories/toilet_repository.dart';
import 'package:toiletmap/app/ui/toilet_detail/widget/detail_images_frame.dart';
import 'package:toiletmap/app/ui/toilet_detail/widget/toilet_information_frame.dart';
import 'package:toiletmap/app/ui/toilet_detail/widget/toilet_rating_frame.dart';
import 'package:toiletmap/app/ui/toilet_detail/widget/toilet_rating_list_frame.dart';

import '../../models/direction/route/leg/distance/distance.dart';
import '../../models/rating/rating.dart';
import '../../models/rating/rating_response.dart';
import '../../models/toilet/toilet.dart';
import '../../models/toilet/toiletArgument.dart';
import '../../repositories/map_repository.dart';
import '../../repositories/shared_preferences_repository.dart';
import '../../utils/constants.dart';
import '../../utils/routes.dart';

class ToiletDetailMainScreen extends StatefulWidget {
  final ToiletArgument toiletArgument;

  ToiletDetailMainScreen({
    required this.toiletArgument,
    Key? key}) : super(key: key);

  @override
  State<ToiletDetailMainScreen> createState() => _ToiletDetailMainScreenState();
}

class _ToiletDetailMainScreenState extends State<ToiletDetailMainScreen> {
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  late Future<int?> _future;
  late Future<List<RatingResponse>?> _future2;

  @override
  void initState() {
    // TODO: implement initState
    _future = RatingRepository().countRatingsByToiletId(widget.toiletArgument.id);
    _future2 = RatingRepository().getRatingsByToiletId(widget.toiletArgument.id, 1, 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String?> imageList = widget!.toiletArgument!.toiletImagesList;
    int toiletId = widget.toiletArgument.id;
    String toiletName = widget.toiletArgument.toiletName;
    double toiletStar = widget.toiletArgument.star;

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
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: AppColor.primaryColor1,
                  ),
                ),

                title: Text('Thông tin nhà vệ sinh'),
                titleTextStyle: AppText.appbarTitleText2,
                centerTitle: true,
                toolbarHeight: 100.h,
                backgroundColor: Colors.white,
                elevation: 1,

                iconTheme: IconThemeData(
                    color: AppColor.primaryColor1
                ),
              ),
            ),
          ),

          floatingActionButton: FloatingActionButton.extended(
          foregroundColor: Colors.black,
          backgroundColor: AppColor.primaryColor2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(20.r),)
          ),
          label: Text("Đến nhà vệ sinh"),
          onPressed: () async {
            QuickAlert.show(
                context: context,
                type: QuickAlertType.loading,
                title: 'Đang tải dữ liệu',
                barrierDismissible: false
            );
            List<double?> latlong = await SharedPreferencesRepository().getCurrentLatLong();
            Toilet? fakeToilet = await ToiletRepository().getToiletByToiletId(widget.toiletArgument.id);
            Distance? distance = await MapRepository().getDistanceFromToilet(latlong[0]!, latlong[1]!, fakeToilet!.latitude, fakeToilet!.longitude);
            int longDistance = await MapRepository().getLongDistance();
            Navigator.pop(context);

            if (distance!.value < longDistance) {
              Navigator.pushNamed(context, Routes.directionMainScreen, arguments: widget.toiletArgument.id);
            } else {
              AwesomeDialog(
                //Ban Tien se config cho ban Quan
                  context: context,
                  dialogType: DialogType.warning,
                  showCloseIcon: true,
                  dismissOnTouchOutside: true,
                  animType: AnimType.topSlide,
                  btnCancelText: 'Hủy',
                  btnCancelOnPress: () {
                  },

                  btnOkColor: AppColor.primaryColor1,
                  btnOkText: 'Xác nhận',
                  btnOkOnPress: () {
                    Navigator.pushNamed(context, Routes.directionMainScreen, arguments: widget.toiletArgument.id);
                  },
                  body: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                    child: RichText(
                      text: TextSpan(
                        text: 'Nhà vệ sinh cách vị trí hiện tại ',
                        style: AppText.blackText18,
                        children: <TextSpan>[
                          TextSpan(text: distance.text, style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: ". Bạn có xác nhận chỉ đường tới nhà vệ sinh không?"),
                        ],
                      ),
                    ),
                  )
              )..show();
            }
          },
          elevation: 0,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

        body: Container(
          color: Color(0xFFF1F1F1),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: DetailImagesFrame(imageSource: widget.toiletArgument!.toiletImagesList,)
                ),
                ToiletInformationFrame(
                  nearBy: widget.toiletArgument.nearBy!,
                  time: widget.toiletArgument.time,
                  disabilityRoom: widget.toiletArgument.disabilityRoom,
                  normalRoom: widget.toiletArgument.normalRoom,
                  showerRoom: widget.toiletArgument.showerRoom,
                  star: widget.toiletArgument.star,
                  price: widget.toiletArgument.price,
                  address: widget.toiletArgument.address,
                  toiletName: widget.toiletArgument.toiletName,
                  toiletFacilities: widget.toiletArgument.facilities,
                ),
                SizedBox(height: 10.h,),
                FutureBuilder<int?> (
                      future: _future,
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
                          return ToiletRatingFrame(ratingCount: snapshot!.data!, ratingStar: toiletStar, toiletId: toiletId, toiletName: toiletName,);
                        }
                        return Center(child: Text('Lỗi'));
                      }),
                FutureBuilder<List<RatingResponse>?> (
                    future: _future2,
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
                        return ToiletRatingListFrame(ratings: snapshot!.data!);
                      }
                      return Container(
                        width: double.infinity,
                        color: Colors.white,
                        child: Column(
                          children: [
                            SizedBox(height: 10.h,),
                            SizedBox(height: 100.w, width: 100.w,
                              child: Image(image: AssetImage('assets/images/no-data.gif'),),),
                            SizedBox(height: 5.h,),
                            Text('Chưa có đánh giá nào', style: AppText.detailText2)
                          ],
                        ),
                      );
                    }),
                Container(
                  height: 80.h,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}