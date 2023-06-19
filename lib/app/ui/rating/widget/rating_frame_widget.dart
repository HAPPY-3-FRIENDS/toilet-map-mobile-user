import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:toiletmap/app/ui/toilet_detail/widget/image_full_widget.dart';
import 'package:toiletmap/app/utils/constants.dart';

import '../../../models/rating/rating.dart';
import '../../../models/rating/rating_response.dart';
import '../../../utils/routes.dart';

class RatingFrameWidget extends StatelessWidget {
  final RatingResponse rating;

  RatingFrameWidget({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(15.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
              child: Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: (rating.avatar != null)
                    ? CachedNetworkImage(
                    imageUrl: rating.avatar!,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => CircleAvatar(
                      radius: 12.w,
                      backgroundImage: AssetImage('assets/default-avatar.png'),),
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      radius: 12.w,
                      backgroundImage: imageProvider),
                )
                    : CircleAvatar(
                  radius: 12.w,
                  backgroundImage: AssetImage('assets/default-avatar.png'),),
              )
          ),
          Expanded(
              flex: 15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${rating.fullName[0]}*******${rating.fullName[rating.fullName.length - 1]}', style: AppText.greyText14,),
                          SizedBox(height: 5.h,),
                          RatingBar.builder(
                            itemSize: 12.w,
                            initialRating: double.parse(rating.star.toString()),
                            ignoreGestures: true,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 0.5.w),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        ],
                      ),
                      InkWell(
                        onTapDown: (details) async {
                          double left = details.globalPosition.dx;
                          double top = details.globalPosition.dy;
                          double right = 360.w - details.globalPosition.dx;
                          double bottom = 900.h - details.globalPosition.dy;

                          await showMenu<String>(
                            context: context,
                            position: RelativeRect.fromLTRB(left, top, right, bottom),
                            items: [
                              PopupMenuItem<String>(
                                value: "Báo cáo",
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, Routes.ratingReportMainScreen, arguments: rating);
                                  },
                                  child: Text('Báo cáo'),
                                ),
                              ),
                            ],
                          );
                        },
                        child: Icon(Icons.more_horiz, size: 16.w, color: Colors.grey,),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h,),
                  Wrap(
                    children: [
                      Text('${rating.comment}', style: AppText.blackText18,),
                    ],
                  ),
                  (rating!.imageSources![0] != null)
                  ? Container(
                    padding: EdgeInsets.only(top: 5.h),
                    height: 90.w,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: (rating!.imageSources!.length < 3) ? rating!.imageSources!.length : 3,
                      itemBuilder: (context, index) {
                        if (rating!.imageSources!.length > 3 && index == 2) {
                          return InkWell(
                            onTap: () => showDialog(
                                context: context,
                                builder: (_) => ImageFullWidget(images: rating!.imageSources!, indexImage: index,)
                            ),
                            child: Container(
                              height: 90.w,
                              width: 90.w,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(rating!.imageSources![index]!,)
                                ),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                color: Colors.black38,
                                child: Text(
                                  '+ ' + (rating!.imageSources!.length - 3).toString(),
                                  style: TextStyle(fontSize: 20.sp, color: Colors.white),
                                ),
                              ),
                            ),
                          );
                        }
                        return InkWell(
                          onTap: () => showDialog(
                              context: context,
                              builder: (_) => ImageFullWidget(images: rating!.imageSources!, indexImage: index,)
                          ),
                          child: Container(
                              child: Container(
                                padding: EdgeInsets.only(right: 7.w),
                                child: Image.network(
                                  height: 90.w,
                                  width: 90.w,
                                  rating!.imageSources![index]!,
                                  fit: BoxFit.cover,
                                ),
                              )
                          ),
                        );
                      }
                    ),
                  ) : Container(height: 0,),
                  SizedBox(height: 5.h,),
                  Text('${rating.dateTime}', style: AppText.greyText16,),
                ],
              ),
          ),
        ],
      ),
    );
  }
}
