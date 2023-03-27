import 'package:flutter/material.dart';

class ImageCarouselWidget extends StatelessWidget {
  const ImageCarouselWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      height: 160,
      decoration: BoxDecoration(
        color: Colors.orange[100]
      ),
      child: PageView.builder(
        itemCount: 4,
          itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
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
