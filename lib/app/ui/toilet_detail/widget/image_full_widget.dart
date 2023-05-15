import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants.dart';

class ImageFullWidget extends StatefulWidget {
  List<String?> images;
  int indexImage;

  ImageFullWidget({Key? key, required this.images, required this.indexImage}) : super(key: key);

  @override
  State<ImageFullWidget> createState() => _ImageFullWidgetState();
}

class _ImageFullWidgetState extends State<ImageFullWidget> {
  final CarouselController carouselController = CarouselController();
  late int currentIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex = widget.indexImage;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            color: Colors.white,
            height: 300.h,
            child: CarouselSlider(
              items: widget.images
                  .map(
                    (item) => Image.network(
                  item!,
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
                initialPage: widget.indexImage,
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
              children: widget.images.asMap().entries.map((entry) {
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
    );
  }
}
