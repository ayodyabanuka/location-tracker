import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

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
    timer =
        Timer.periodic(Duration(seconds: 3), (Timer t) => getCurrentLocation());
    super.initState();
  }

  var locationMessage = "";

  void getCurrentLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator.getLastKnownPosition();

    print(lastPosition);
    setState(() {
      locationMessage = "{$position}";
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
            const Text(
              'User Current Location',
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(locationMessage),
            // FlatButton(
            //   onPressed: () {

            //   },
            //   child: const Text(
            //     "Get location",
            //     style: TextStyle(color: Colors.white),
            //   ),
            //   color: Colors.blue,
            // )
          ],
        ),
      ),
    );
  }
}
