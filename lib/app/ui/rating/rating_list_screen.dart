import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:toiletmap/app/repositories/rating_repository.dart';
import 'package:toiletmap/app/ui/rating/widget/rating_frame_widget.dart';
import 'package:toiletmap/app/models/toilet/toiletArgument2.dart';
import 'package:toiletmap/app/ui/rating/widget/rating_list_widget.dart';

import '../../models/rating/rating.dart';
import '../../models/rating/rating_response.dart';
import '../../utils/constants.dart';

class RatingListScreen extends StatefulWidget {
  ToiletArgument2 toiletArgument2;

  RatingListScreen({Key? key, required this.toiletArgument2}) : super(key: key);

  @override
  State<RatingListScreen> createState() => _RatingListScreenState();
}

class _RatingListScreenState extends State<RatingListScreen> {
  late int money1;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();
  final scrollController = ScrollController();
  bool isLoadingMore = false;
  List posts = [];
  int page = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    money1 = 0;
    scrollController.addListener(_scrollListener);
    _fetchPosts(page);
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        backgroundColor: Colors.white,
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

                title: Text('Đánh giá'),
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

          body: Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  height: 60.h,
                  padding: EdgeInsets.only(left: 14.w, right: 14.w, top: 14.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(padding: EdgeInsets.only(left: 1.w),
                                child: Wrap(
                                  children: [
                                    Text('${widget.toiletArgument2.toiletName}', style: AppText.blackText20Bold, maxLines: 1, overflow: TextOverflow.ellipsis),
                                  ],
                                )
                            ),
                          ),
                          Expanded(flex: 1, child: Row(
                            children: [
                              RatingBar.builder(
                                itemSize: 18.w,
                                initialRating: widget.toiletArgument2.ratingStar,
                                ignoreGestures: true,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding: EdgeInsets.symmetric(horizontal: 1.w),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5.w),
                                child: Text(
                                  '${widget.toiletArgument2.ratingStar}/5.0 (${widget.toiletArgument2.ratingCount} Đánh giá)',
                                  style: AppText.greyText18,
                                ),
                              )
                            ],
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
                GroupButton(
                  onSelected: (value, index, isSelected) {
                    print('index ne' + index.toString());
                    switch (index) {
                      case 0:
                        (money1 == 1) ?
                        setState(() {
                          money1 = 0;
                          _fetchPosts(1);
                          posts = [];
                        }) : setState(() {
                          money1 = 1;
                          _fetchPosts(1);
                          posts = [];
                        });
                        break;
                      case 1:
                        (money1 == 2) ?
                        setState(() {
                          money1 = 0;
                          _fetchPosts(1);
                          posts = [];
                        }) : setState(() {
                          money1 = 2;
                          _fetchPosts(1);
                          posts = [];
                        });
                        break;
                      case 2:
                        (money1 == 3) ?
                        setState(() {
                          money1 = 0;
                          _fetchPosts(1);
                          posts = [];
                        }) : setState(() {
                          money1 = 3;
                          _fetchPosts(1);
                          posts = [];
                        });
                        break;
                      case 3:
                        (money1 == 4) ?
                        setState(() {
                          money1 = 0;
                          _fetchPosts(1);
                          posts = [];
                        }) : setState(() {
                          money1 = 4;
                          _fetchPosts(1);
                          posts = [];
                        });
                        break;
                      case 4:
                        (money1 == 5) ?
                        setState(() {
                          money1 = 0;
                          _fetchPosts(1);
                          posts = [];
                        }) : setState(() {
                          money1 = 5;
                          _fetchPosts(1);
                          posts = [];
                        });
                        break;
                    }
                  },
                  maxSelected: 1,
                  enableDeselect: true,
                  options: GroupButtonOptions(
                    buttonWidth: 100.w,
                    selectedColor: (money1 != 0) ? AppColor.primaryColor2 : Colors.white,
                    unselectedColor: Colors.white,
                    selectedBorderColor: (money1 != 0) ? AppColor.primaryColor1 : AppColor.primaryColor2,
                    unselectedBorderColor: AppColor.primaryColor2,
                    borderRadius: BorderRadius.circular(10.r),
                    elevation: 0,
                    selectedShadow: [],
                    unselectedShadow: [],
                    mainGroupAlignment: MainGroupAlignment.start,
                    crossGroupAlignment: CrossGroupAlignment.start,
                    selectedTextStyle: AppText.blackText20,
                    groupingType: GroupingType.wrap,
                    unselectedTextStyle: AppText.blackText20,
                    runSpacing: 0.h,
                    textPadding: EdgeInsets.zero
                  ),

                  buttons: ["1 sao",'2 sao','3 sao','4 sao','5 sao'],
                ),
                Container(
                  //yêu hay không yêu, không yêu hay yêu nói một lời
                  height: 550.h,
                  child: (widget.toiletArgument2.ratingCount != 0)
                      ? RefreshIndicator(
                      key: _refreshIndicatorKey,
                      color: AppColor.primaryColor1,
                      backgroundColor: Colors.white,
                      strokeWidth: 2.0,
                      onRefresh: () async {
                        setState(() {
                          posts = [];
                          page = 1;
                        });
                        _fetchPosts(page);
                        return Future<void>.delayed(const Duration(seconds: 3));
                      },
                      // Pull from top to show refresh indicator.
                      child: Container(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: isLoadingMore ? posts.length + 1 : posts.length,
                          controller: scrollController,
                          itemBuilder: (BuildContext context, int index) {
                            if (index < posts.length) {
                              RatingResponse rating = posts[index];
                              return Column(
                                children: [
                                  Container(height: 2.h, color: Color(0xFFF1F1F1),),
                                  RatingFrameWidget(rating: rating,),
                                ],
                              );
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                      )
                  )
                      : Container(
                    child: Column(
                      children: [
                        SizedBox(height: 10.h,),
                        SizedBox(height: 200.w, width: 200.w,
                          child: Image(image: AssetImage('assets/images/no-data.gif'),),),
                        SizedBox(height: 10.h,),
                        Text('Chưa có đánh giá nào', style: AppText.detailText2)
                      ],
                    ),
                  )
                )
              ],
            ),
          )
      ),
    );
  }

  Future<void> _fetchPosts(int page) async {
    List<RatingResponse>? set = await RatingRepository().getRatingsByToiletId(widget.toiletArgument2.id, page, money1);
    setState(() {
      posts = posts + set!;
    });
  }

  Future<void> _scrollListener() async {
    print("position reating list: "  + scrollController.position.pixels.toString());
    if (isLoadingMore) return;
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      setState(() {
        isLoadingMore = true;
      });
      page += 1;
      await _fetchPosts(page);
      setState(() {
        isLoadingMore = false;
      });
    }
  }
}

