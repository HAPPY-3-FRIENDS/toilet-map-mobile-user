import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toiletmap/app/utils/constants.dart';

class DetailImagesFrame extends StatefulWidget {
  List<String> imageSource;

  DetailImagesFrame({required this.imageSource, Key? key}) : super(key: key);

  @override
  State<DetailImagesFrame> createState() => _DetailImagesFrameState();
}

class _DetailImagesFrameState extends State<DetailImagesFrame> {
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          height: 300.h,
          child: CarouselSlider(
            items: widget.imageSource
                .map(
                  (item) => CachedNetworkImage(
                  imageUrl: item,
                  placeholder: (context, url) => SizedBox(
                    child: Center(
                        child: CircularProgressIndicator()
                    ),
                    height: 20.w,
                    width: 20.w,
                  ),
                  errorWidget: (context, url, error) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/toilet-detail-no-image.png'),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fitHeight,
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
            children: widget.imageSource.asMap().entries.map((entry) {
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
    );
  }
}
