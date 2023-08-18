import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toiletmap/app/main.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:toiletmap/app/repositories/map_repository.dart';
import 'package:toiletmap/app/repositories/shared_preferences_repository.dart';
import 'package:toiletmap/app/repositories/toilet_repository.dart';
import 'package:toiletmap/app/ui/home/home_main_map/widget/bottom_sheet_toilet_info.dart';
import 'package:toiletmap/app/utils/constants.dart';

import '../../../models/toilet/toilet.dart';
import '../../../utils/routes.dart';

class HomeMainMap extends StatefulWidget {

  const HomeMainMap({Key? key}) : super(key: key);

  static bool isPermissionLocation = false;

  @override
  State<HomeMainMap> createState() => _HomeMainMapState();
}

class _HomeMainMapState extends State<HomeMainMap> {
  late CameraPosition _initialCameraPosition;
  late MapboxMapController controller;
  late LatLng currentLatLng;

  @override
  void initState() {
    // TODO: implement initState
    _getCurrentLocation();
    super.initState();
  }

  Future<CameraPosition> initializeLocationAndSave() async {
    if (HomeMainMap.isPermissionLocation == false) {
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
      await SharedPreferencesRepository().setCurrentLatLong(_locationData.latitude!, _locationData.longitude!);

      HomeMainMap.isPermissionLocation = true;
    } else {
      List<double?> list = await SharedPreferencesRepository().getCurrentLatLong();
      currentLatLng = LatLng(list[0]!, list[1]!);
    }

    return CameraPosition(target: currentLatLng, zoom: 16);
  }

  _onMapCreated(MapboxMapController controller) async {
    this.controller = controller;
  }

  _symbolClick(Symbol symbol) async {
    showModalBottomSheet(
      shape: AppShapeBorder.shapeBorder2,
        context: context,
        builder: (BuildContext context) {
          return BottomSheetToiletInfo(id: symbol.data!['id']);
        }
    );
  }

  _loadSymbols(double lat, double long, int toiletId) async {
    await controller.addSymbol(
        SymbolOptions(
          //bool - keo tha icon
          draggable: false,
          geometry: LatLng(lat, long),
          iconImage: 'assets/marker.png',
          iconSize: 1,
          //fontNames: ['Roboto Regular'],
        ),
        {
          'id': toiletId,
          'lat': lat,
          'long': long
        }
    );
  }

  _getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then(
        (location) {
          currentLatLng = LatLng(location.latitude!, location.longitude!);
        }
    );

    SharedPreferencesRepository().setCurrentLatLong(currentLatLng.latitude, currentLatLng.longitude);

    location.onLocationChanged.listen((event) {
      currentLatLng = LatLng(event.latitude!, event.longitude!);
    });
  }

  _onStyleLoadedCallback() async {
    print('current location ' + currentLatLng.latitude.toString() + " " + currentLatLng.longitude.toString());

    final symbols = await MapRepository().getAllPosition();

    symbols!.forEach((element) {
      _loadSymbols(element.latitude, element.longitude, element.id);
    });
    controller.onSymbolTapped.add((argument) {_symbolClick(argument);});
    /*
    update - dung de ghi de len cho symbol (ko phai xoa)
    controller.updateSymbol(symbol1, SymbolOptions(
      geometry: LatLng()
    ));
    */
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 180.h),
      child: Container(
        height: 700.h,
        child: SizedBox(
            child: FutureBuilder(
              future: initializeLocationAndSave(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _initialCameraPosition =
                      CameraPosition(target: currentLatLng);
                  return Stack(
                    children: [
                      Container(
                        height: 680.h,
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
                        top: 500.h,
                        left: 288.w,
                        child:  FloatingActionButton(
                            child: Icon(Icons.my_location),
                            onPressed: () {
                              controller.animateCamera(
                                  CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(currentLatLng.latitude, currentLatLng.longitude))));}
                        ),
                      ),

                      Padding(
                          padding: EdgeInsets.only(
                              left: 10.w,
                          right: 10.w,
                          top: 90.h,),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, Routes.searchMainScreen);
                              },
                              child: Container(
                                width: 250.w,
                                height: 45.h,
                                child: Row(
                                  children: [
                                    Padding(padding: EdgeInsets.symmetric(horizontal: 15.w), child:
                                    Icon(Icons.search, size: 20.w, color: AppColor.primaryColor1,),),
                                    Text("Tìm kiếm địa chỉ", style: AppText.greyText18,),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.w),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 0.5,
                                      blurRadius: 1,
                                      offset: Offset(0, 0.5), // changes position of shadow
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 45.h,
                              width: 80.w,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  elevation: 1,
                                  backgroundColor: AppColor.primaryColor1,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                                ),
                                onPressed: () async {
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.loading,
                                    title: 'Đang tải dữ liệu',
                                      barrierDismissible: false
                                  );

                                  Toilet? toilet = await ToiletRepository().getNearestToilet();
                                  Navigator.pop(context);
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
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                  Navigator.pushNamed(context, Routes.directionMainScreen, arguments: toilet!.id);
                                },
                                child: Text('Khẩn cấp', style: AppText.titleText1),
                              ),
                            )
                          ],
                        )
                      ),
                    ],
                  );
                } else {
                  return Container(
                      child: Center(
                        child: SizedBox(
                          height: 25.w,
                          width: 25.w,
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
}