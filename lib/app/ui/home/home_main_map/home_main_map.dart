import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toiletmap/app/main.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:toiletmap/app/utils/constants.dart';

class HomeMainMap extends StatefulWidget {
  const HomeMainMap({Key? key}) : super(key: key);

  @override
  State<HomeMainMap> createState() => _HomeMainMapState();
}

class _HomeMainMapState extends State<HomeMainMap> {
  late CameraPosition _initialCameraPosition;
  late MapboxMapController controller;


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
    LatLng currentLatLng = LatLng(_locationData.latitude!, _locationData.longitude!);

    sharedPreferences.setDouble('latitude', _locationData.latitude!);
    sharedPreferences.setDouble('longtitude', _locationData.longitude!);

    return CameraPosition(target: currentLatLng, zoom: 15);
  }

  _onMapCreated(MapboxMapController controller) async {
    this.controller = controller;
  }

  _onStyleLoadedCallback() async{}

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: AppSize.heightScreen / 4),
      child: Container(
        height: AppSize.heightScreen / 1.5,
        child: SizedBox(
            child: FutureBuilder(
              future: initializeLocationAndSave(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _initialCameraPosition =
                      CameraPosition(target: LatLng(sharedPreferences.getDouble('latitude')!, sharedPreferences.getDouble('longtitude')!));
                  return Stack(
                    children: [
                      MapboxMap(
                        accessToken: 'pk.eyJ1Ijoiam5vb2xqb29sIiwiYSI6ImNsZjl1YTlseDB0ZWozeG8xNWlkc2UyazMifQ.fNwINfQKuqfP2daikOu8bw',
                        initialCameraPosition: _initialCameraPosition,
                        onMapCreated: _onMapCreated,
                        onStyleLoadedCallback: _onStyleLoadedCallback,
                        myLocationEnabled: true,
                        myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
                        minMaxZoomPreference: const MinMaxZoomPreference(14, 17),
                      ),

                      Positioned(
                        top: AppSize.heightScreen * 0.53,
                        left: AppSize.widthScreen * 0.8,
                        child:  FloatingActionButton(
                            child: Icon(Icons.my_location),
                            onPressed: () {
                              controller.animateCamera(
                                  CameraUpdate.newCameraPosition(_initialCameraPosition));}
                        ),
                      ),

                      Padding(
                          padding: EdgeInsets.only(
                              left: AppSize.widthScreen / 50,
                          right: AppSize.widthScreen / 50,
                          top: AppSize.heightScreen / 40,),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: AppSize.widthScreen / 1.4,
                              height: AppNumber.h20,
                              child: TextField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  isDense: true,
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(AppNumber.h35),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: "Tìm kiếm địa chỉ",
                                  prefixIcon: Icon(Icons.search),
                                  prefixIconColor: AppColor.primaryColor1,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: AppNumber.h20,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: AppColor.primaryColor1,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppNumber.h45)),
                                ),
                                onPressed: () {},
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
                      child: const Center(
                        child: SizedBox(
                          height: 25,
                          width: 25,
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