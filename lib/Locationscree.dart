import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_tracker/Providers/locationProvider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';

class locationtracker extends StatefulWidget {
  locationtracker({Key? key}) : super(key: key);

  @override
  State<locationtracker> createState() => _locationtrackerState();
}

class _locationtrackerState extends State<locationtracker> {
  Timer? timer;

  @override
  void initState() {
    Permission.locationWhenInUse.isGranted;
    getCurrentLocation();
    timer = Timer.periodic(
        const Duration(seconds: 30), (Timer t) => getCurrentLocation());
    super.initState();
  }

  var locationMessagelongtitude = "";
  var locationMessagelatitude = "";

  void getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // var lastPosition = await Geolocator.getLastKnownPosition();
    var latitude = position.latitude;
    var longtitude = position.longitude;
    _locationadd(latitude, longtitude);
    setState(() {
      locationMessagelatitude = latitude.toString();
      locationMessagelongtitude = longtitude.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Location Tracker')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.location_on,
              size: 46,
              color: Colors.blue,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Latitude : " + locationMessagelatitude,
                  ),
                  Text(
                    "Longtitude : " + locationMessagelongtitude,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }

  _locationadd(latitude, longtitude) async {
    var res = await locationProvider().AddLocation(latitude, longtitude);
    print(res.body);
  }
}
