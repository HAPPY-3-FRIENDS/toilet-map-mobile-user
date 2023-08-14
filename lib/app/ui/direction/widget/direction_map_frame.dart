import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toiletmap/app/main.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:toiletmap/app/repositories/map_repository.dart';
import 'package:toiletmap/app/repositories/shared_preferences_repository.dart';
import 'package:toiletmap/app/repositories/toilet_repository.dart';
import 'package:toiletmap/app/ui/home/home_main_map/widget/bottom_sheet_toilet_info.dart';
import 'package:toiletmap/app/ui/home/home_main_screen.dart';
import 'package:toiletmap/app/utils/constants.dart';

import '../../../models/place/place.dart';
import '../../../models/place/prediction/prediction.dart';
import '../../../models/placeDetail/place_detail.dart';
import '../../../models/toilet/toilet.dart';
import '../../../models/toilet/toiletFacilities/toiletFacilities.dart';
import '../../../repositories/place_repository.dart';
import '../../../utils/routes.dart';
import '../../location_report/widget/location_report_dialog.dart';

class DirectionMapFrame extends StatefulWidget {
  Toilet toilet;

  DirectionMapFrame({required this.toilet, Key? key}) : super(key: key);

  @override
  State<DirectionMapFrame> createState() => _DirectionMapFrameState();
}

class _DirectionMapFrameState extends State<DirectionMapFrame> {
  bool isOnThisPage = true;
  static int countLineway = 0;

  List<Prediction> data = [];
  bool isSearch = false;
  bool isSeeking = false;
  late CameraPosition _initialCameraPosition;
  late MapboxMapController controller;
  late LatLng currentLatLng;

  late Timer timer1;
  late Timer timer2;
  bool isPopup = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer1 = Timer.periodic(Duration(seconds: 15), (Timer t) {
      _getPopup();
    });
    isOnThisPage = true;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer1.cancel();
    timer2.cancel();
    super.dispose();
  }

  void _getPopup() async {
    String? status = await ToiletRepository().getToiletStatus(widget.toilet.id);
    if (status! == 'Not available') {
      setState(() {
        isPopup = true;
      });
    } else {
      setState(() {
        isPopup = false;
      });
    }
  }

  Future<CameraPosition> initializeLocationAndSave() async {
    List<double?> list = await SharedPreferencesRepository().getCurrentLatLong();
    currentLatLng = LatLng(list[0]!, list[1]!);

    return CameraPosition(target: currentLatLng, zoom: 16);
  }

  _onMapCreated(MapboxMapController controller) async {
    this.controller = controller;

    timer2 = Timer.periodic(Duration(seconds: 8), (Timer t) {
      _getCurrentLocation();
    });
  }

  _loadSymbols(double lat, double long, int toiletId) async {
    await controller.addSymbol(
        SymbolOptions(
          //bool - keo tha icon
          draggable: false,
          geometry: LatLng(lat, long),
          iconImage: 'assets/marker.png',
          iconSize: 1,
        ),
        {
          'id': toiletId,
          'lat': lat,
          'long': long
        }
    );
  }

  _createPolyline(double firstLat, double firstLng) async {
    countLineway +=1;

    String way = 'way' + countLineway.toString();
    String line = 'line' + countLineway.toString();
    print('wayline: ' + way + ' ' + line);
    print("this is check for latlong: " + firstLat.toString());
    print("this is check for latlong: " + firstLng.toString());
    print("this is check for latlong: " + widget.toilet.latitude.toString());
    print("this is check for latlong: " + widget.toilet.longitude.toString());

    var polyline = await MapRepository().getDirection(firstLat, firstLng, widget.toilet.latitude, widget.toilet.longitude);

    var fills = await {
      "type": "FeatureCollection",
      "features": [
        {
          'type': 'Feature',
          'properties': {},
          'geometry': {
            'type': 'LineString',
            'coordinates': polyline,
          },
        },
      ],
    };
    print("fills: " + fills.toString());

    await controller.addSource(way, GeojsonSourceProperties(data: fills));
    await controller.addLineLayer(way, line, LineLayerProperties(
      lineColor:'#007AFF',
      lineCap: "round",
      lineJoin: "round",
      lineWidth: 3,
    ),);
  }

  _onStyleLoadedCallback() async {
    print('current location ' + currentLatLng.latitude.toString() + " " + currentLatLng.longitude.toString());

    final symbol = widget.toilet;

    _loadSymbols(symbol!.latitude, symbol!.longitude, symbol!.id);
  }

  _getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then(
            (location) {
          currentLatLng = LatLng(location.latitude!, location.longitude!);
        }
    );

    String? status = await ToiletRepository().getToiletStatus(widget.toilet.id);
    int? waitTime = await ToiletRepository().getToiletWaitTime(widget.toilet.id);

    SharedPreferencesRepository().setCurrentLatLong(currentLatLng.latitude, currentLatLng.longitude);

    if (isSearch == false && isOnThisPage == true) {
      controller.animateCamera(
          CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(currentLatLng.latitude, currentLatLng.longitude))));

      double d1 = (widget.toilet.longitude - currentLatLng.longitude)*(widget.toilet.longitude - currentLatLng.longitude);
      double d2 = (widget.toilet.latitude - currentLatLng.latitude)*(widget.toilet.latitude - currentLatLng.latitude);

      double sum = (d1 + d2) * 1000000;

      setState(() {
        if (sum >= 0.1) {
          _createPolyline(currentLatLng.latitude, currentLatLng.longitude);
          controller.removeLayer('line' + (countLineway-1).toString());
          controller.removeSource('way' + (countLineway-1).toString());
        } else if (isSeeking == false) {
          controller.removeLayer('line' + countLineway.toString());
          controller.removeSource('way' + countLineway.toString());

          isOnThisPage = false;

          if (status! == "Not available") {
            Navigator.pushNamed(context, Routes.homeMainScreen);
            //Navigator.pop(context);
            AwesomeDialog(
              context: context,
              dialogType: DialogType.noHeader,
              showCloseIcon: true,
              dismissOnTouchOutside: true,
              animType: AnimType.topSlide,
              body: LocationReportDialog(id: widget.toilet.id, waitTime: waitTime!),
            )..show();
          } else {
            //note
            Navigator.pushNamed(context, Routes.homeMainScreen);
            AwesomeDialog(
              context: context,
              dismissOnTouchOutside: true,
              dialogType: DialogType.noHeader,
              showCloseIcon: true,
              animType: AnimType.topSlide,
              body: LocationReportDialog(id: widget.toilet.id, waitTime: 0),
            )..show();
          }
        }
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    Toilet toilet;

    return Padding(
      padding: EdgeInsets.zero,
      child: Container(
        //height: AppSize.heightScreen / 1.3,
        child: SizedBox(
            child: FutureBuilder(
              future: initializeLocationAndSave(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _initialCameraPosition =
                      CameraPosition(target: currentLatLng);
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                            height: 130.h,
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(height: 10.h,),
                                    Icon(Icons.circle_outlined, size: 17.w, color: Colors.black54,),
                                    Icon(Icons.circle, size: 3.w, color: Colors.black54),
                                    Icon(Icons.circle, size: 3.w, color: Colors.black54),
                                    Icon(Icons.circle, size: 3.w, color: Colors.black54),
                                    Icon(Icons.location_on_outlined, size: 20.w, color: Colors.red,),
                                    SizedBox(height: 10.h,),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: 300.w,
                                      height: 45.h,
                                      child: Form(
                                        child: TextFormField(
                                          onChanged: (value) => setState(() => {
                                            if (value != '') {
                                              updateList(value)
                                            } else {
                                              data = [],
                                              updateList(value),
                                              if (isSearch == true) {
                                                controller.removeLayer('line' + countLineway.toString()),
                                                controller.removeSource('way' + countLineway.toString()),
                                                _createPolyline(currentLatLng.latitude, currentLatLng.longitude),
                                                isSearch = false
                                              }
                                            }
                                          }),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                top: 0,
                                                bottom: 0,
                                                left: 10.w
                                            ),
                                            hintText: "Vị trí hiện tại",
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.r),
                                              borderSide: BorderSide(color: Colors.grey),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.r),
                                              borderSide: BorderSide(color: AppColor.primaryColor1),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 300.w,
                                      height: 45.h,
                                      child: Form(
                                        child: TextFormField(
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                top: 0,
                                                bottom: 0,
                                                left: 10.w
                                            ),
                                            hintStyle: AppText.primary1Text18,
                                            hintText: widget.toilet.toiletName,
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.r),
                                              borderSide: BorderSide(color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )
                        ),
                        (data.length != 0)
                        ? Container(
                          height: 400.h,
                          child: Expanded(
                            child: ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index) => ListTile(
                                  onTap: () async {
                                    PlaceDetail? detail = await PlaceRepository().getPlaceDetail(data[index].place_id);
                                    setState(() {
                                      isSearch = true;
                                    });
                                    await controller.removeLayer('line' + countLineway.toString());
                                    await controller.removeSource('way' + countLineway.toString());
                                    await _createPolyline(detail!.result!.geometry.location.lat, detail!.result!.geometry.location.lng);
                                    await controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(detail!.result!.geometry.location.lat, detail!.result!.geometry.location.lng))));
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    setState(() {
                                      data = [];
                                    });
                                    },
                                  title: Text(data[index].description),
                                )),
                          ),)
                        : Container(),
                        Stack(
                          children: [
                            Container(
                              height: 630.h,  //Phuong phone 640
                              width: 360.w,
                              child: MapboxMap(
                                //Link goong -> user goong map
                                styleString: AppString.styleString,
                                accessToken: 'pk.eyJ1Ijoiam5vb2xqb29sIiwiYSI6ImNsZjl1YTlseDB0ZWozeG8xNWlkc2UyazMifQ.fNwINfQKuqfP2daikOu8bw',
                                initialCameraPosition: _initialCameraPosition,
                                onMapCreated: _onMapCreated,
                                onStyleLoadedCallback: _onStyleLoadedCallback,
                                myLocationEnabled: true,
                                myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
                                minMaxZoomPreference: const MinMaxZoomPreference(15, 18),

                              ),
                            ),
                            Positioned(
                              top: (isPopup) ? 400.h : 430.h,
                              left: 288.w,
                              child:  FloatingActionButton(
                                  child: Icon(Icons.my_location),
                                  onPressed: () {
                                    controller.animateCamera(
                                        CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(currentLatLng.latitude, currentLatLng.longitude))));}
                              ),
                            ),
                            Padding(
                                padding: (isPopup)
                                    ? EdgeInsets.only(left: 20.w, right: 20.w, top: 500.h)
                                    : EdgeInsets.only(left: 30.w, right: 30.w, top: 550.h),
                                child: (isPopup)
                                    ? Column(
                                  children: [
                                    Text('Nhà vệ sinh có thể đang quá tải, bạn có muốn được chỉ đường tới nhà vệ sinh khác gần đây không?', style: AppText.blackText18Bold,),
                                    SizedBox(height: 10.h,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 145.w,
                                          height: 50.h,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: AppColor.primaryColor1,
                                                  elevation: 1,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10.r))),
                                              onPressed: () async {
                                                isSeeking = true;

                                                QuickAlert.show(
                                                  context: context,
                                                  type: QuickAlertType.loading,
                                                  title: 'Đang tải dữ liệu',
                                                  barrierDismissible: false
                                                );

                                                Toilet? toilet = await ToiletRepository().getNearestToilet();
                                                if (toilet == null) {
                                                  showDialog<void>(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text('Chú ý'),
                                                        content: const Text('Không tìm thấy nhà vệ sinh phù hợp!'),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            child: const Text('Xác nhận'),
                                                            onPressed: () {
                                                              isSeeking = false;
                                                              isOnThisPage = false;
                                                              Navigator.pushNamed(context, Routes.homeMainScreen);
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                } else {
                                                  Navigator.pushNamed(context, Routes.directionMainScreen, arguments: toilet!.id);
                                                }
                                              },
                                              child: Text("Tới NVS khác", style: AppText.white100Text20,)
                                          ),
                                        ),
                                        SizedBox(
                                          width: 145.w,
                                          height: 50.h,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.white,
                                                  elevation: 1,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10.r))),
                                              onPressed: () async {
                                                isOnThisPage = false;
                                                Navigator.pushNamed(context, Routes.homeMainScreen);
                                              },
                                              child: Text("Ngừng chỉ đường", style: AppText.primary1Text20,)
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                                    : SizedBox(
                                  width: double.infinity,
                                  height: 50.h,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                          elevation: 1,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.r))),
                                      onPressed: () async {
                                        isOnThisPage = false;
                                        Navigator.pushNamed(context, Routes.homeMainScreen);
                                      },
                                      child: Text("Hoàn tất", style: AppText.primary1Text20,)
                                  ),
                                ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container(
                      child: Center(
                        child: SizedBox(
                          height: 20.w,
                          width: 20.w,
                          child: CircularProgressIndicator(),
                        ),
                      )
                  );
                }
              },
            )
        ),
      ),
    );
  }

  void updateList(String value) async {
    Place? places = await PlaceRepository().getPlace(value);

    setState(() {
      data = places!.predictions!;
    });

  }
}


