import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toiletmap/app/main.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:toiletmap/app/repositories/map_repository.dart';
import 'package:toiletmap/app/ui/home/home_main_map/widget/bottom_sheet_toilet_info.dart';
import 'package:toiletmap/app/utils/constants.dart';

class HomeMainMap extends StatefulWidget {
  const HomeMainMap({Key? key}) : super(key: key);

  @override
  State<HomeMainMap> createState() => _HomeMainMapState();
}

class _HomeMainMapState extends State<HomeMainMap> {
  late CameraPosition _initialCameraPosition;
  late MapboxMapController controller;
  late LatLng currentLatLng;
  static int count = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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

  _symbolClick(Symbol symbol) async {
    /*showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Chú ý'),
          content: Text(symbol.data!['id'].toString()),
          actions: <Widget>[
            TextButton(
              child: const Text('Xác nhận'),
              onPressed: () {
                _createPolyline(symbol.data!['lat'], symbol.data!['long']);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );*/

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

  _createPolyline(double lat, double long) async {
    count += 1;
    var polyline = await MapRepository().getDirection(currentLatLng.latitude, currentLatLng.longitude, lat, long);

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

    await controller.addSource("way${count}", GeojsonSourceProperties(data: fills));
    await controller.addLineLayer("way${count}", "line${count}", LineLayerProperties(
      lineColor:'#007AFF',
      lineCap: "round",
      lineJoin: "round",
      lineWidth: 3,
    ),);
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
                      CameraPosition(target: LatLng(sharedPreferences.getDouble('latitude')!, sharedPreferences.getDouble('longtitude')!));
                  return Stack(
                    children: [
                      Container(
                        height: 700.h,
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
                                  CameraUpdate.newCameraPosition(_initialCameraPosition));}
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
                            SizedBox(
                              width: 250.w,
                              height: 45.h,
                              child: TextField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  isDense: true,
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.r),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: "Tìm kiếm địa chỉ",
                                  prefixIcon: Icon(Icons.search),
                                  prefixIconColor: AppColor.primaryColor1,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 45.h,
                              width: 80.w,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: AppColor.primaryColor1,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                                ),
                                onPressed: () async {
                                  await controller.removeSource("way${count}");
                                  await controller.removeLayer("line${count}");
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