import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toiletmap/app/models/commonComment/common_comment.dart';
import 'package:toiletmap/app/repositories/common_comment_repository.dart';
import 'package:toiletmap/app/ui/rating/widget/rating_main_rating_frame_widget/common_comments_frame.dart';
import 'package:toiletmap/app/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../models/checkin/checkin.dart';
import '../../../models/rating/rating.dart';
import '../../../repositories/rating_repository.dart';
import '../../../utils/routes.dart';

class RatingMainRatingFrame extends StatefulWidget {
  Checkin checkin;

  RatingMainRatingFrame({Key? key, required this.checkin}) : super(key: key);

  @override
  State<RatingMainRatingFrame> createState() => _RatingMainRatingFrameState();
}

class _RatingMainRatingFrameState extends State<RatingMainRatingFrame> {
  String comment = '';
  int star = 0;
  List<String> imageSources = [];
  List<Map<String, String>> imageSS = [];
  int status = 0;
  late Timer _timer;

  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.length + imageFileList!.length > 5) {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Chú ý'),
            content: const Text('Chỉ được chọn tối đa 5 tấm hình'),
            actions: <Widget>[
              TextButton(
                child: const Text('Xác nhận'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    if (selectedImages!.isNotEmpty && selectedImages!.length + imageFileList!.length <= 5) {
      imageFileList!.addAll(selectedImages);
    }
    setState(() {
      status = 1;
    });
  }

  Future uploadImages() async {
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('rating-images');
    setState(() {
      imageSources = [];
    });

    imageFileList.forEach((element) async {
      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);
      try {
        await referenceImageToUpload.putFile(File(element.path));
        String string = await referenceImageToUpload.getDownloadURL();
        print ("String ne: " + string);
        imageSources.add(string);
        setState(() {
        });
      } catch (error) {
        print(error);
      }
      print("length imageSource: " + imageSources.length.toString());
    });

    setState(() {
      status = 0;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("Đánh giá", style: AppText.blackText20,),
                SizedBox(width: 30.w,),
                RatingBar.builder(
                  itemSize: 25.w,
                  initialRating: 0,
                  ignoreGestures: false,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 1.w),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    star = rating.toInt();
                    print(rating);
                  },
                ),
              ],
            ),
            SizedBox(height: 20.h,),
            Text("Báo cáo nhà vệ sinh", style: AppText.blackText20,),
            SizedBox(height: 10.h,),
            const CommonCommentsFrame(),
            (imageFileList.length != 0)
            ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100.h,
                  width: AppSize.widthScreen,
                  child: Padding(
                    padding: EdgeInsets.all(5.w),
                    child: GridView.builder(
                      itemCount: imageFileList!.length + 1,
                      scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 2.w,
                          mainAxisSpacing: 2.w,
                          crossAxisCount: 1
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        if (index != imageFileList!.length) {
                          return Stack(
                            children: [
                              Image.file(File(imageFileList[index].path),
                                height: 80.w,
                                width: 80.w,
                                fit: BoxFit.fill,),
                              InkWell(
                                onTap: () {
                                  imageFileList.removeAt(index);
                                  if (imageFileList.isNotEmpty) {
                                    setState(() {
                                      status = 1;
                                    });
                                  } else {
                                    setState(() {
                                      status = 0;
                                      imageSources = [];
                                    });
                                  }
                                },
                                child: Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      child: Icon(Icons.close, size: 18.w, color: Colors.white,),
                                      color: Colors.black26,
                                    )
                                ),
                              )
                            ],
                          );
                        } else {
                          if (imageFileList!.length <= 4) {
                            return InkWell(
                              child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1, color: AppColor.primaryColor1),
                                  ),
                                  height: 80.w,
                                  width: 80.w,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.camera_alt_rounded, size: 20.w, color: AppColor.primaryColor1,),
                                      SizedBox(height: 5.h,),
                                      Text('Thêm ảnh', style: AppText.primary1Text18,),
                                    ],
                                  )
                              ),
                              onTap: () {
                                selectImages();
                              },
                            );
                          }
                          return Container(width: 0,);
                        }
                      },
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 10.w), child: Text('${imageFileList.length}/5', style: AppText.blackText16,),),
              ],
            )
            : Container(
              child:  Padding(padding: EdgeInsets.only(left: 10.w), child: Text('*Tối đa 5 ảnh', style: AppText.blackText16,),),
            ),
            SizedBox(height: 10.h,),
            (imageFileList.isEmpty)
                ? InkWell(
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    border: Border.all(width: 1, color: AppColor.primaryColor1),
                  ),
                  height: 100.h,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.camera_alt_rounded, size: 30.w, color: AppColor.primaryColor1,),
                      Text('Thêm hình ảnh', style: AppText.primary1Text20,),
                    ],
                  )
              ),
              onTap: () {
                selectImages();
              },
            ) : Container(),
            SizedBox(height: 20.h,),
            Text("Viết đánh giá", style: AppText.blackText20,),
            SizedBox(
              height: 100.h,
              child: TextField(
                onChanged: (value) => setState(() => {
                  comment = value
                }),
                maxLines: null,
                expands: true, // and this
                keyboardType: TextInputType.multiline,
                maxLength: 500,
              ),
            ),
            SizedBox(height: 20.h,),
            (status == 0)
                ? Align(
              alignment: Alignment.center,
              child: FloatingActionButton.extended(
                foregroundColor: Colors.black,
                backgroundColor: AppColor.primaryColor2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.r),)
                ),
                label: Text("Đánh giá"),
                onPressed: () async {
                  if (star == 0) {
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Chú ý'),
                          content: const Text('Vui lòng đánh giá số sao!'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Xác nhận'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                  else if (comment == '') {
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Chú ý'),
                          content: const Text('Vui lòng viết nhận xét!'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Xác nhận'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                  else {
                    print("Hinh nè: " + imageSources.length.toString());
                    Rating? rating = await RatingRepository().postRating(widget.checkin.toiletId, star, comment, widget.checkin.id, imageSources);
                      if (rating != null) {
                        Navigator.pushNamed(context, Routes.homeMainScreen);
                      } else {
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Chú ý'),
                              content: const Text('Lỗi đánh giá'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Xác nhận'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                  }
                  },
                elevation: 0,
              ),
            )
                : Align(
              alignment: Alignment.center,
              child: FloatingActionButton.extended(
                foregroundColor: Colors.black,
                backgroundColor: AppColor.primaryColor2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.r),)
                ),
                label: Text("Tải hình"),
                onPressed: () async {
                  await uploadImages();
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext builderContext) {
                        _timer = Timer(Duration(seconds: 3), () {
                          Navigator.of(context).pop();
                        });
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          content: SingleChildScrollView(
                            child: Column(
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(height: 10.h),
                                Text('Đang tải ảnh'),
                              ],
                            ),
                          ),
                        );
                      }
                  ).then((val){
                    if (_timer.isActive) {
                      _timer.cancel();
                    }
                  });
                },
                elevation: 0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
