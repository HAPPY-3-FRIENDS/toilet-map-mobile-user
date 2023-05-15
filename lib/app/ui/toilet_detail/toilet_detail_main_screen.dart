import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toiletmap/app/repositories/rating_repository.dart';
import 'package:toiletmap/app/ui/toilet_detail/widget/detail_images_frame.dart';
import 'package:toiletmap/app/ui/toilet_detail/widget/toilet_information_frame.dart';
import 'package:toiletmap/app/ui/toilet_detail/widget/toilet_rating_frame.dart';
import 'package:toiletmap/app/ui/toilet_detail/widget/toilet_rating_list_frame.dart';

import '../../models/rating/rating.dart';
import '../../models/toilet/toiletArgument.dart';
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
  late ScrollController _scrollController;
  late Future<int?> _future;
  late Future<List<Rating>?> _future2;
  double _scrollControllerOffset = 0.0;

  _scrollListener() {
    setState(() {
      _scrollControllerOffset = _scrollController.offset;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _future = RatingRepository().countRatingsByToiletId(widget.toiletArgument.id);
    _future2 = RatingRepository().getRatingsByToiletId(widget.toiletArgument.id, 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String?> imageList = widget!.toiletArgument!.toiletImagesList;
    int toiletId = widget.toiletArgument.id;
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

          persistentFooterButtons: [],
          floatingActionButton: FloatingActionButton.extended(
          foregroundColor: Colors.black,
          backgroundColor: AppColor.primaryColor2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(20.r),)
          ),
          label: Text("Đến nhà vệ sinh"),
          onPressed: () {
            Navigator.pushNamed(context, Routes.directionMainScreen, arguments: widget.toiletArgument.id);
          },
          elevation: 0,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

        body: Container(
          color: Color(0xFFF1F1F1),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      color: Colors.white,
                      height: 300.h,
                      child: CarouselSlider(
                        items: widget.toiletArgument!.toiletImagesList
                            .map(
                              (item) => Image.network(
                            item,
                            fit: BoxFit.fitHeight,
                          ),
                        )
                            .toList(),
                        carouselController: carouselController,
                        options: CarouselOptions(
                          scrollPhysics: const BouncingScrollPhysics(),
                          autoPlay: true,
                          height: 300.h,
                          viewportFraction: 1,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10.h,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: imageList.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () => carouselController.animateToPage(entry.key),
                            child: Container(
                              width: currentIndex == entry.key ? 17.w : 7.w,
                              height: 7.0.w,
                              margin: EdgeInsets.symmetric(
                                horizontal: 3.0.w,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: currentIndex == entry.key
                                      ? AppColor.primaryColor1
                                      : Colors.white),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
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
                          return ToiletRatingFrame(ratingCount: snapshot!.data!, ratingStar: toiletStar, toiletId: toiletId);
                        }
                        return Center(child: Text('Lỗi'));
                      }),
                FutureBuilder<List<Rating>?> (
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
                      if (!snapshot.hasData) {
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
                      }
                      return Center(child: Text('Lỗi'));
                    }),
                Container(
                  height: 100.h,
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

/* This one is more beautiful but cann't use yet
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toiletmap/app/ui/toilet_detail/widget/detail_images_frame.dart';
import 'package:toiletmap/app/ui/toilet_detail/widget/toilet_information_frame.dart';

import '../../models/toilet/toiletArgument.dart';
import '../../utils/constants.dart';
import '../../utils/routes.dart';

class ToiletDetailMainScreen extends StatefulWidget {
  ToiletArgument toiletArgument;

  ToiletDetailMainScreen({
    required this.toiletArgument,
    Key? key}) : super(key: key);

  @override
  State<ToiletDetailMainScreen> createState() => _ToiletDetailMainScreenState();
}

class _ToiletDetailMainScreenState extends State<ToiletDetailMainScreen> {
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  late ScrollController _scrollController;
  double _scrollControllerOffset = 0.0;

  _scrollListener() {
    setState(() {
      _scrollControllerOffset = _scrollController.offset;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String?> imageList = widget!.toiletArgument!.toiletImagesList;

    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        /*persistentFooterButtons: [],
        floatingActionButton: FloatingActionButton.extended(
          foregroundColor: Colors.black,
          backgroundColor: AppColor.primaryColor2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(20.r),)
          ),
          label: Text("Đến nhà vệ sinh"),
          onPressed: () {
            Navigator.pushNamed(context, Routes.directionMainScreen, arguments: widget.toiletArgument.id);
          },
          elevation: 0,

        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,*/

        body: Container(
            color: Color(0xFFF1F1F1),
            child: Stack(
              children: [
                SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                color: Colors.white,
                                height: 300.h,
                                child: CarouselSlider(
                                  items: widget.toiletArgument!.toiletImagesList
                                      .map(
                                        (item) => Image.network(
                                      item,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  )
                                      .toList(),
                                  carouselController: carouselController,
                                  options: CarouselOptions(
                                    scrollPhysics: const BouncingScrollPhysics(),
                                    autoPlay: true,
                                    height: 300.h,
                                    viewportFraction: 1,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        currentIndex = index;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10.h,
                                left: 0,
                                right: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: imageList.asMap().entries.map((entry) {
                                    return GestureDetector(
                                      onTap: () => carouselController.animateToPage(entry.key),
                                      child: Container(
                                        width: currentIndex == entry.key ? 17.w : 7.w,
                                        height: 7.0.w,
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 3.0.w,
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.r),
                                            color: currentIndex == entry.key
                                                ? AppColor.primaryColor1
                                                : Colors.white),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
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
                          SizedBox(height: 15.h,),
                          Container(color: Colors.black, height: 2000.h,),
                        ],
                      ),
                ),
                PreferredSize(
                    child: Container(
                      height: 100.h,
                      color: Colors.white.withOpacity((_scrollControllerOffset / 300.h).clamp(0, 1).toDouble()),
                      child: Container(
                        child: Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(width: 10.w,),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(
                                      Icons.arrow_back_ios_rounded,
                                      color: Colors.white.withOpacity((1 - _scrollControllerOffset / 300.h).clamp(0, 1).toDouble()),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      shape: CircleBorder(),
                                      padding: EdgeInsets.all(10.w),
                                      backgroundColor: Colors.black38.withOpacity((1 - _scrollControllerOffset / 200.h).clamp(0, 1).toDouble()), // <-- Button color
                                      foregroundColor: Colors.black38.withOpacity((1 - _scrollControllerOffset / 200.h).clamp(0, 1).toDouble()),// <-- Splash color
                                    ),
                                  ),
                                ],
                              ),],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(width: 10.w,),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(
                                      Icons.arrow_back_ios_rounded,
                                      color: AppColor.primaryColor1.withOpacity((_scrollControllerOffset / 300.h).clamp(0, 1).toDouble()),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      shape: CircleBorder(),
                                      padding: EdgeInsets.all(10.w),
                                      backgroundColor: Colors.transparent, // <-- Button color
                                      foregroundColor: Colors.transparent
                                    ),
                                  ),
                                  SizedBox(
                                    width: 60.w,
                                  ),
                                  Text("Thông tin", style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 30.sp,
                                    color: AppColor.primaryColor1.withOpacity((_scrollControllerOffset / 300.h).clamp(0, 1).toDouble()),),)
                                ],
                              ),],
                            )
                          ],
                        )
                      ),
                    ),
                    preferredSize: Size(100.h, 20.w)
                )
              ],
            ),
          ),
      )
    );
  }
}
* */