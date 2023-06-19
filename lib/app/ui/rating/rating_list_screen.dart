import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toiletmap/app/repositories/rating_repository.dart';
import 'package:toiletmap/app/ui/rating/widget/rating_frame_widget.dart';
import 'package:toiletmap/app/models/toilet/toiletArgument2.dart';

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
    scrollController.addListener(_scrollListener);
    _fetchPosts(page);
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

          body: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    height: 100.h,
                    padding: EdgeInsets.all(14.w),
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
                                      Text('${widget.toiletArgument2.toiletName}', style: AppText.blackText20Bold, maxLines: 2, overflow: TextOverflow.ellipsis),
                                    ],
                                  )
                              ),
                            ),
                            Expanded(flex: 2, child: Row(
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
                  (widget.toiletArgument2.ratingCount == 0)
                  ? Container(
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
                  : RefreshIndicator(
                key: _refreshIndicatorKey,
                color: AppColor.primaryColor1,
                backgroundColor: Colors.white,
                strokeWidth: 2.0,
                onRefresh: () async {
                  // Replace this delay with the code to be executed during refresh
                  // and return a Future when code finishs execution.
                  return Future<void>.delayed(const Duration(seconds: 3));
                },
                // Pull from top to show refresh indicator.
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: isLoadingMore ? posts.length + 1 : posts.length,
                      controller: scrollController,
                      itemBuilder: (BuildContext context, int index) {
                        RatingResponse rating = posts[index];
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
                  ],
                ),

                /*Column(
                            children: [
                              ListView.builder(
                                  controller: scrollController,
                                  itemCount: 4,//isLoadingMore ? posts.length + 1 : posts.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    if (index < posts.length) {
                                      Rating rating = posts[index];
                                      return Container(
                                    padding: EdgeInsets.only(top: 2.h),
                                    child: RatingFrameWidget(rating: rating,),
                                  );
                                    } else {
                                      return Center(child: CircularProgressIndicator());
                                    }
                                  },
                                ),
                            ],
                          ),*/
              ),
                ],
              ),
            )
          )
      ),
    );
  }

  Future<void> _fetchPosts(int page) async {
    List<RatingResponse>? set = await RatingRepository().getRatingsByToiletId(widget.toiletArgument2.id, page);
    setState(() {
      posts = posts + set!;
    });
  }

  Future<void> _scrollListener() async {
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

