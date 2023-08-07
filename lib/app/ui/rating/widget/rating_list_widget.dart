import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toiletmap/app/repositories/rating_repository.dart';
import 'package:toiletmap/app/ui/rating/widget/rating_frame_widget.dart';
import 'package:toiletmap/app/models/toilet/toiletArgument2.dart';

import '../../../models/rating/rating_response.dart';
import '../../../utils/constants.dart';

class RatingListWidget extends StatefulWidget {
  ToiletArgument2 toiletArgument2;
  int star;

  RatingListWidget({Key? key, required this.toiletArgument2, required this.star}) : super(key: key);

  @override
  State<RatingListWidget> createState() => _RatingListWidgetState();
}

class _RatingListWidgetState extends State<RatingListWidget> {
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
    return (widget.toiletArgument2.ratingCount != 0)
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
    );
  }

  Future<void> _fetchPosts(int page) async {
    List<RatingResponse>? set = await RatingRepository().getRatingsByToiletId(widget.toiletArgument2.id, page, widget.star);
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

