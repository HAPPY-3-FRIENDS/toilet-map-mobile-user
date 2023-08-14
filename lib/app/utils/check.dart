/*
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

  DirectionMapFrame({required this.toilet,Key? key}) : super(key: key);

  @override
  State<DirectionMapFrame> createState() => _DirectionMapFrameState();
}

class _DirectionMapFrameState extends State<DirectionMapFrame> {
  List<Prediction> data = [];
  bool isSearch = false;
  bool isSeeking = false;
  bool isOnThisPage = true;
  late CameraPosition _initialCameraPosition;
  late MapboxMapController controller;
  late LatLng currentLatLng;
  static int count = 0;

  late Timer timer;
  bool isPopup = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentLocation();
    Timer.periodic(Duration(seconds: 15), (Timer t) {
      _getPopup();
    });
    Timer.periodic(Duration(seconds: 5), (Timer t) {
      _getCurrentLocation();
    });
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
    Location _location = Location();
    bool? _serviceEnabled;
    PermissionStatus? _permissionGranted;
    sharedPreferences = await SharedPreferences.getInstance();

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
    }

    LocationData _locationData = await _location.getLocation();
    currentLatLng = LatLng(_locationData.latitude!, _locationData.longitude!);

    sharedPreferences.setDouble('latitude', _locationData.latitude!);
    sharedPreferences.setDouble('longtitude', _locationData.longitude!);

    return CameraPosition(target: currentLatLng, zoom: 16);
  }

  _onMapCreated(MapboxMapController controller) async {
    this.controller = controller;
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
    count +=1;

    String way = 'way' + count.toString();
    String line = 'line' + count.toString();
    print('wayline: ' + way + ' ' + line);
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

    if (isSearch == false && isOnThisPage == true) {
      controller.animateCamera(
          CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(currentLatLng.latitude, currentLatLng.longitude))));

      double d1 = (widget.toilet.longitude - currentLatLng.longitude)*(widget.toilet.longitude - currentLatLng.longitude);
      double d2 = (widget.toilet.latitude - currentLatLng.latitude)*(widget.toilet.latitude - currentLatLng.latitude);

      double sum = (d1 + d2) * 1000000;

      setState(() {
        if (sum >= 0.1) {
          _createPolyline(currentLatLng.latitude, currentLatLng.longitude);
          controller.removeLayer('line' + (count-1).toString());
          controller.removeSource('way' + (count-1).toString());
        } else if (isSeeking == false) {
          controller.removeLayer('line' + count.toString());
          controller.removeSource('way' + count.toString());

          isOnThisPage = false;
          Navigator.pushNamed(context, Routes.homeMainScreen);
          if (status! == "Not available") {
            Navigator.pushNamed(context, Routes.homeMainScreen);
            AwesomeDialog(
              context: context,
              dialogType: DialogType.noHeader,
              showCloseIcon: true,
              dismissOnTouchOutside: true,
              animType: AnimType.topSlide,
              body: LocationReportDialog(id: widget.toilet.id, waitTime: waitTime!),
            )..show();
          } else {
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
                                                controller.removeLayer('line' + count.toString()),
                                                controller.removeSource('way' + count.toString()),
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
                                    await controller.removeLayer('line' + count.toString());
                                    await controller.removeSource('way' + count.toString());
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
                              height: 640.h,
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
                                                            Navigator.of(context).pop();
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              } else {
                                                Navigator.pushReplacementNamed(context, Routes.directionMainScreen, arguments: toilet!.id);
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
                                              Navigator.pushReplacementNamed(context, Routes.homeMainScreen);
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
                                      Navigator.pushReplacementNamed(context, Routes.homeMainScreen);
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


*/
