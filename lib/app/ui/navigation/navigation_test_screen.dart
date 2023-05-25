/*
import 'package:flutter/material.dart';
import 'package:flutter_mapbox_navigation/library.dart';

class NavigationTestScreen extends StatefulWidget {
  const NavigationTestScreen({Key? key}) : super(key: key);

  @override
  State<NavigationTestScreen> createState() => _NavigationTestScreenState();
}

class _NavigationTestScreenState extends State<NavigationTestScreen> {
  late MapBoxNavigationViewController _controller;
  final cityhall = WayPoint(name: "City Hall", latitude: 42.886448, longitude: -78.878372);
  final downtown = WayPoint(name: "Downtown Buffalo", latitude: 42.8866177, longitude: -78.8814924);

  var wayPoints = <WayPoint>[];
  late MapBoxNavigation _directions;
  late MapBoxOptions _options;
  double? distanceRemaining, durationRemaining;

  final bool _isMultipleStop = false;
  String? _instruction = "";
  bool? _arrived = false;
  bool _routeBuilt = false;
  bool _isNavigating = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    if (!mounted) return;

    _directions = MapBoxNavigation(onRouteEvent: _onRouteEvent);

    _options = MapBoxOptions(
        initialLatitude: 36.1175275,
        initialLongitude: -115.1839524,
        zoom: 13.0,
        tilt: 0.0,
        bearing: 0.0,
        enableRefresh: false,
        alternatives: true,
        voiceInstructionsEnabled: true,
        bannerInstructionsEnabled: true,
        allowsUTurnAtWayPoints: true,
        mode: MapBoxNavigationMode.drivingWithTraffic,
        mapStyleUrlDay: "https://url_to_day_style",
        mapStyleUrlNight: "https://url_to_night_style",
        units: VoiceUnits.imperial,
        simulateRoute: true,
        language: "vi");

    wayPoints.add(cityhall);
    wayPoints.add(downtown);

    await _directions.startNavigation(wayPoints: wayPoints, options: _options);
await MapBoxNavigation.instance.startNavigation(wayPoints: wayPoints);

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: MapBoxNavigationView(
          options: _options,
          onRouteEvent: _onRouteEvent,
          onCreated:
              (MapBoxNavigationViewController controller) async {
            _controller = controller;
          }),
    );
  }

  Future<void> _onRouteEvent(e) async {
distanceRemaining = await _directions.getDistanceRemaining();
    durationRemaining = await _directions.getDurationRemaining();


    distanceRemaining = await _directions.distanceRemaining;
    durationRemaining = await _directions.durationRemaining;

    switch (e.eventType) {
      case MapBoxEvent.progress_change:
        var progressEvent = e.data as RouteProgressEvent;
        _arrived = progressEvent.arrived;
        if (progressEvent.currentStepInstruction != null)
          _instruction = progressEvent.currentStepInstruction;
        break;
      case MapBoxEvent.route_building:
      case MapBoxEvent.route_built:
        _routeBuilt = true;
        break;
      case MapBoxEvent.route_build_failed:
        _routeBuilt = false;
        break;
      case MapBoxEvent.navigation_running:
        _isNavigating = true;
        break;
      case MapBoxEvent.on_arrival:
        _arrived = true;
        if (!_isMultipleStop) {
          await Future.delayed(Duration(seconds: 3));
          await _controller.finishNavigation();
        } else {}
        break;
      case MapBoxEvent.navigation_finished:
      case MapBoxEvent.navigation_cancelled:
        _routeBuilt = false;
        _isNavigating = false;
        break;
      default:
        break;
    }
    //refresh UI
    setState(() {});
  }
}
*/
