import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toiletmap/app/utils/constants.dart';

class ImagesFrame extends StatelessWidget {
  List<String> imageSource;

  ImagesFrame({required this.imageSource, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (imageSource.length) {
      case 0:
        return Container(
          height: 200.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/toilet-detail-no-image.png'),
            ),
          ),
        );
      case 1:
        return CachedNetworkImage(
            imageUrl: imageSource[0],
            placeholder: (context, url) => SizedBox(
              child: Center(
                  child: CircularProgressIndicator()
              ),
              height: 20.w,
              width: 20.w,
            ),
            errorWidget: (context, url, error) => Container(
              height: 200.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/toilet-detail-no-image.png'),
                ),
              ),
            ),
            imageBuilder: (context, imageProvider) => Container(
              height: 200.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: imageProvider,
                ),
              ),
            ),
        );
      case 2:
        return Container(
          height: 200.h,
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: CachedNetworkImage(
                      imageUrl: imageSource[0],
                      placeholder: (context, url) => SizedBox(
                        child: Center(
                            child: CircularProgressIndicator()
                        ),
                        height: 20.w,
                        width: 20.w,
                      ),
                      errorWidget: (context, url, error) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.r),
                              bottomLeft: Radius.circular(10.r)
                          ),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/toilet-detail-no-image.png'),
                          ),
                        ),
                      ),
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.r),
                              bottomLeft: Radius.circular(10.r)
                          ),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: imageProvider
                          ),
                        ),
                      )
                  ),
              ),
              VerticalDivider(
                width: 5,
                color: Colors.white,
              ),
              Expanded(
                  flex: 1,
                  child: CachedNetworkImage(
                      imageUrl: imageSource[1],
                      placeholder: (context, url) => SizedBox(
                        child: Center(
                            child: CircularProgressIndicator()
                        ),
                        height: 20.w,
                        width: 20.w,
                      ),
                      errorWidget: (context, url, error) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.r),
                              bottomRight: Radius.circular(10.r)
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/toilet-detail-no-image.png'),
                          ),
                        ),
                      ),
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.r),
                              bottomRight: Radius.circular(10.r)
                          ),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: imageProvider
                          ),
                        ),
                      )
                  ),
              ),
            ],
          ),
        );
      case 3:
        return Container(
          height: 200.h,
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: CachedNetworkImage(
                      imageUrl: imageSource[0],
                      placeholder: (context, url) => SizedBox(
                        child: Center(
                            child: CircularProgressIndicator()
                        ),
                        height: 20.w,
                        width: 20.w,
                      ),
                      errorWidget: (context, url, error) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.r),
                              bottomLeft: Radius.circular(10.r)
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/toilet-detail-no-image.png'),
                          ),
                        ),
                      ),
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.r),
                              bottomLeft: Radius.circular(10.r)
                          ),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: imageProvider
                          ),
                        ),
                      )
                  ),
              ),
              VerticalDivider(
                width: 5,
                color: Colors.white,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: CachedNetworkImage(
                          imageUrl: imageSource[1],
                          placeholder: (context, url) => SizedBox(
                            child: Center(
                                child: CircularProgressIndicator()
                            ),
                            height: 20.w,
                            width: 20.w,
                          ),
                          errorWidget: (context, url, error) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10.r),
                              ),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/images/toilet-detail-no-image.png'),
                              ),
                            ),
                          ),
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10.r),
                              ),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: imageProvider
                              ),
                            ),
                          ),
                      ),
                      ),
                    Divider(
                      height: 5,
                      color: Colors.white,
                    ),
                    Expanded(
                      flex: 1,
                      child: CachedNetworkImage(
                        imageUrl: imageSource[2],
                        placeholder: (context, url) => SizedBox(
                          child: Center(
                              child: CircularProgressIndicator()
                          ),
                          height: 20.w,
                          width: 20.w,
                        ),
                        errorWidget: (context, url, error) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10.r),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/toilet-detail-no-image.png'),
                            ),
                          ),
                        ),
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10.r),
                            ),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: imageProvider
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      case 4:
        return Container(
          height: 200.h,
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                  flex: 3,
                  child: CachedNetworkImage(
                      imageUrl: imageSource[0],
                      placeholder: (context, url) => SizedBox(
                        child: Center(
                            child: CircularProgressIndicator()
                        ),
                        height: 20.w,
                        width: 20.w,
                      ),
                      errorWidget: (context, url, error) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.r),
                              bottomLeft: Radius.circular(10.r)
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/toilet-detail-no-image.png'),
                          ),
                        ),
                      ),
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.r),
                              bottomLeft: Radius.circular(10.r)
                          ),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: imageProvider
                          ),
                        ),
                      )
                  ),
              ),
              VerticalDivider(
                width: 5,
                color: Colors.white,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: CachedNetworkImage(
                        imageUrl: imageSource[1],
                        placeholder: (context, url) => SizedBox(
                          child: Center(
                              child: CircularProgressIndicator()
                          ),
                          height: 20.w,
                          width: 20.w,
                        ),
                        errorWidget: (context, url, error) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.r),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/toilet-detail-no-image.png'),
                            ),
                          ),
                        ),
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.r),
                            ),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: imageProvider
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 5,
                      color: Colors.white,
                    ),
                    Expanded(
                      flex: 1,
                      child: CachedNetworkImage(
                        imageUrl: imageSource[2],
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
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/toilet-detail-no-image.png'),
                            ),
                          ),
                        ),
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: imageProvider
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 5,
                      color: Colors.white,
                    ),
                    Expanded(
                      flex: 1,
                      child: CachedNetworkImage(
                        imageUrl: imageSource[3],
                        placeholder: (context, url) => SizedBox(
                          child: Center(
                              child: CircularProgressIndicator()
                          ),
                          height: 20.w,
                          width: 20.w,
                        ),
                        errorWidget: (context, url, error) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10.r),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/toilet-detail-no-image.png'),
                            ),
                          ),
                        ),
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10.r),
                            ),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: imageProvider
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      default:
        return Container(
          color: Colors.white,
          height: 200.h,
          child: Row(
            children: [
              Expanded(
                  flex: 3,
                  child: CachedNetworkImage(
                      imageUrl: imageSource[0],
                      placeholder: (context, url) => SizedBox(
                        child: Center(
                            child: CircularProgressIndicator()
                        ),
                        height: 20.w,
                        width: 20.w,
                      ),
                      errorWidget: (context, url, error) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.r),
                              bottomLeft: Radius.circular(10.r)
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/toilet-detail-no-image.png'),
                          ),
                        ),
                      ),
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.r),
                              bottomLeft: Radius.circular(10.r)
                          ),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: imageProvider
                          ),
                        ),
                      )
                  ),
              ),
              VerticalDivider(
                width: 5,
                color: Colors.white,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: CachedNetworkImage(
                        imageUrl: imageSource[1],
                        placeholder: (context, url) => SizedBox(
                          child: Center(
                              child: CircularProgressIndicator()
                          ),
                          height: 20.w,
                          width: 20.w,
                        ),
                        errorWidget: (context, url, error) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.r),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/toilet-detail-no-image.png'),
                            ),
                          ),
                        ),
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.r),
                            ),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: imageProvider
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 5,
                      color: Colors.white,
                    ),
                    Expanded(
                      flex: 1,
                      child: CachedNetworkImage(
                        imageUrl: imageSource[2],
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
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/toilet-detail-no-image.png'),
                            ),
                          ),
                        ),
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: imageProvider
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 5,
                      color: Colors.white,
                    ),
                    Expanded(
                      flex: 1,
                      child: CachedNetworkImage(
                        imageUrl: imageSource[3],
                        placeholder: (context, url) => SizedBox(
                          child: Center(
                              child: CircularProgressIndicator()
                          ),
                          height: 20.w,
                          width: 20.w,
                        ),
                        errorWidget: (context, url, error) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10.r),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/toilet-detail-no-image.png'),
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10.r),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '+ ' + (imageSource.length - 4).toString(),
                              style: TextStyle(fontSize: 20.sp, color: Colors.white),
                            ),
                          ),
                        ),
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10.r),
                            ),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: imageProvider
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10.r),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '+ ' + (imageSource.length - 4).toString(),
                              style: TextStyle(fontSize: 20.sp, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
    }
  }
}
