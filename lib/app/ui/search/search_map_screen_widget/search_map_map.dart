import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toiletmap/app/main.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:toiletmap/app/repositories/map_repository.dart';
import 'package:toiletmap/app/repositories/toilet_repository.dart';
import 'package:toiletmap/app/ui/home/home_main_map/widget/bottom_sheet_toilet_info.dart';
import 'package:toiletmap/app/utils/constants.dart';

import '../../../models/placeDetail/place_detail.dart';
import '../../../models/toilet/toilet.dart';
import '../../../utils/routes.dart';

class SearchMapMap extends StatefulWidget {
  PlaceDetail placeDetail;

  SearchMapMap({Key? key, required this.placeDetail}) : super(key: key);

  @override
  State<SearchMapMap> createState() => _SearchMapMapState();
}

class _SearchMapMapState extends State<SearchMapMap> {
  late CameraPosition _initialCameraPosition;
  late MapboxMapController controller;
  late LatLng currentLatLng;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<CameraPosition> initializeLocationAndSave() async {
    currentLatLng = LatLng(widget.placeDetail.result.geometry.location.lat, widget.placeDetail.result.geometry.location.lng);

    return CameraPosition(target: currentLatLng, zoom: 16);
  }

  _onMapCreated(MapboxMapController controller) async {
    this.controller = controller;
  }

  _symbolClick(Symbol symbol) async {
    (symbol.data!['id'] != 0) ? showModalBottomSheet(
        shape: AppShapeBorder.shapeBorder2,
        context: context,
        builder: (BuildContext context) {
          return BottomSheetToiletInfo(id: symbol.data!['id']);
        }
    ) : null;
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

  _onStyleLoadedCallback() async {
    print('current location ' + currentLatLng.latitude.toString() + " " + currentLatLng.longitude.toString());

    final symbols = await MapRepository().getAllPosition();

    symbols!.forEach((element) {
      _loadSymbols(element.latitude, element.longitude, element.id);
    });

    await controller.addSymbol(
        SymbolOptions(
          //bool - keo tha icon
          draggable: false,
          geometry: LatLng(widget.placeDetail.result.geometry.location.lat, widget.placeDetail.result.geometry.location.lng),
          iconImage: 'assets/search-marker.png',
          iconSize: 1,
          //fontNames: ['Roboto Regular'],
        ),
        {
          'id': 0,
          'lat': 1,
          'long': 1
        }
    );

    controller.onSymbolTapped.add((argument) {_symbolClick(argument);});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 0.h),
      child: Container(
        height: 800.h,
        child: SizedBox(
            child: FutureBuilder(
              future: initializeLocationAndSave(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _initialCameraPosition =
                      CameraPosition(target: LatLng(widget.placeDetail.result.geometry.location.lat, widget.placeDetail.result.geometry.location.lng));
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
                          myLocationTrackingMode: MyLocationTrackingMode.None,
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