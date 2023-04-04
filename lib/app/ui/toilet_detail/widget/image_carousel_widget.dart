import 'package:flutter/material.dart';
import 'package:toiletmap/app/utils/constants.dart';

class ImageCarouselWidget extends StatelessWidget {
  const ImageCarouselWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.heightScreen / 3,
      child: PageView.builder(
        itemCount: 4,
          itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://media-cdn-v2.laodong.vn/Storage/NewsPortal/2022/5/9/1042801/Nha-Ve-Sinh1.jpg'),
                fit: BoxFit.cover
              ),
            ),
          );
          }),
    );
  }
}
