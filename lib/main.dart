import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

import 'package:location_tracker/Providers/locationProvider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';

import 'Locationscree.dart';

var locationMessagelongtitude = "";
var locationMessagelatitude = "";

const backrun = 'backrunsimple';
Timer? timer;

void callbackDispatcher() {
  Workmanager().executeTask((
    taskName,
    inputData,
  ) {
    switch (taskName) {
      case backrun:
        getCurrentLocation();
        print("location");
        break;
    }
    print("Task executing :" + taskName);

    return Future.value(true);
  });
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => locationProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Location Tracker',
      home: locationtracker(),
    );
  }
}

void getCurrentLocation() async {
  var position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  // var lastPosition = await Geolocator.getLastKnownPosition();
  var latitude = position.latitude;
  var longtitude = position.longitude;
  Fluttertoast.showToast(msg: 'updated location');
  print(latitude);
  print(longtitude);
  // _locationadd(latitude, longtitude);
}

_locationadd(latitude, longtitude) async {
  var res = await locationProvider().AddLocation(latitude, longtitude);
  print(res.body);
}
