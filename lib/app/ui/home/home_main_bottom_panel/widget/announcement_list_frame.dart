import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toiletmap/app/models/announcement/announcement.dart';
import 'package:toiletmap/app/repositories/announcement_repository.dart';
import 'package:toiletmap/app/utils/routes.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/constants.dart';

class AnnouncementListFrame extends StatefulWidget {
  List<Announcement> announcements;

  AnnouncementListFrame({Key? key, required this.announcements}) : super(key: key);

  @override
  State<AnnouncementListFrame> createState() => _AnnouncementListFrameState();
}

class _AnnouncementListFrameState extends State<AnnouncementListFrame> {
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          height: 150.h,
          child: CarouselSlider(
            items: widget.announcements
                .map(
                  (item) => CachedNetworkImage(
                  imageUrl: item.imageSource,
                  placeholder: (context, url) => SizedBox(
                    child: Center(
                        child: CircularProgressIndicator()
                    ),
                    height: 20.w,
                    width: 20.w,
                  ),
                  errorWidget: (context, url, error) => Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Lỗi tải ảnh", style: AppText.detailText3,),
                        SizedBox(height: 20.h,),
                        Icon(Icons.error_outline_rounded, size: 20.w, color: Colors.black54,)
                      ],
                    ),
                  ),
                  imageBuilder: (context, imageProvider) => InkWell(
                    onTap: () {
                      if (item.type == "External") {
                        final url = Uri.parse(item.url!);
                        launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                      else {
                        Navigator.pushNamed(context, Routes.announcementMainScreen, arguments: item);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  )
              ),
            )
                .toList(),
            carouselController: carouselController,
            options: CarouselOptions(
              scrollPhysics: const BouncingScrollPhysics(),
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: widget.announcements.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => carouselController.animateToPage(entry.key),
                child: Container(
                  width: currentIndex == entry.key ? 7.w : 3.w,
                  height: 3.0.w,
                  margin: EdgeInsets.symmetric(
                    horizontal: 3.0.w,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: currentIndex == entry.key
                          ? Colors.white
                          : Colors.white),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
